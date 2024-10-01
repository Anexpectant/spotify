import 'dart:convert';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:spotify/core/utils/services/alert_handler/failures.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/core/utils/services/localization/languages.dart';
import 'package:spotify/core/utils/services/logger/logger.dart';
import 'package:spotify/src/base/data/data_sources/base_local_data_source.dart';

abstract class RestDataSource {
  static String BASE_URL = "restBaseUrl";

  final LocalDataSource configDataSource = getIt<LocalDataSource>();
  late final PackageInfo packageInfo;
  late final BaseDeviceInfo deviceInfo;
  RestDataSource() {
    if (kIsWeb || !Platform.environment.containsKey('FLUTTER_TEST')) {
      _initPackageInfo();
    }
  }

  Future<void> _initPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
    final deviceInfoPlugin = DeviceInfoPlugin();
    deviceInfo = kIsWeb
        ? await deviceInfoPlugin.webBrowserInfo
        : await deviceInfoPlugin.deviceInfo;
  }

  String getDeviceProperty(String key, {String? secondKey}) {
    if (!deviceInfo.toMap().keys.contains(key)) return 'null';
    if (deviceInfo.toMap()[key] is Map &&
        secondKey != null &&
        deviceInfo.toMap()[key].keys.contains(secondKey)) {
      return deviceInfo.toMap()[key][secondKey].toString();
    }
    return deviceInfo.toMap()[key].toString();
  }

  Future<Map<String, dynamic>> get(String urlString,
      {bool utf8Support = true,
      bool withToken = true,
      bool autoHandleWithStatusCode = true,
      BuildContext? context}) async {
    try {
      var url = Uri.parse(BASE_URL + urlString);
      final headers = await getHeaders(withToken: withToken);
      final response = await http.get(url, headers: headers);
      final responseJson = _response(
          httpResponse: response,
          autoHandleWithStatusCode: autoHandleWithStatusCode,
          utf8Support: utf8Support);
      responseJson.addAll({'code': response.statusCode});
      getIt<Logger>()
          .debug(responseJson.toString(), title: 'rest get response');

      return responseJson;
    } on Failure catch (e) {
      throw e;
    } on SocketException {
      if (await _noConnection()) {
        throw FetchDataFailure(
            Languages.of(context).noConnectionFailureMessage);
      }
      throw FetchDataFailure(Languages.of(context).fetchDataFailureMessage);
    } catch (e) {
      throw AccessDeniedFailure(Languages.of(context).fetchDataFailureMessage);
    }
  }

  Future<Map<String, dynamic>> post(String urlString,
      {required Map body,
      bool withToken = true,
      bool utf8Support = true,
      bool autoHandleWithStatusCode = true,
      BuildContext? context}) async {
    var responseJson;
    try {
      var url = Uri.parse(BASE_URL + urlString);
      final headers = await getHeaders(withToken: withToken);
      final response =
          await http.post(url, body: jsonEncode(body), headers: headers);
      responseJson = _response(
          httpResponse: response,
          autoHandleWithStatusCode: autoHandleWithStatusCode,
          utf8Support: utf8Support);
      responseJson.addAll({'code': response.statusCode});
      getIt<Logger>()
          .debug(responseJson.toString(), title: 'rest post response');
    } on Failure catch (e) {
      throw e;
    } on SocketException {
      if (await _noConnection()) {
        throw FetchDataFailure(
            Languages.of(context).noConnectionFailureMessage);
      }
      throw FetchDataFailure(Languages.of(context).fetchDataFailureMessage);
    } catch (e) {
      getIt<Logger>().debug(e.toString());
      throw AccessDeniedFailure(Languages.of(context).fetchDataFailureMessage);
    }
    return responseJson;
  }

  Future<dynamic> httpPostFormData(
      {required String url,
      http.MultipartFile? file,
      requestType,
      fields,
      BuildContext? context,
      bool withToken = false}) async {
    try {
      var request = http.MultipartRequest(requestType, Uri.parse(url));
      request.fields.addAll(fields);
      if (file != null) request.files.add(file);
      request.headers.addAll(getHeaders(withToken: withToken));
      return request.send();
    } on Failure catch (e) {
      throw e;
    } on SocketException {
      throw FetchDataFailure(Languages.of(context).fetchDataFailureMessage);
    } catch (e) {
      throw AccessDeniedFailure(Languages.of(context).fetchDataFailureMessage);
    }
  }

  getHeaders({bool withToken = true}) async {
    final headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json",
      'Client-Platform': 'Flutter${kIsWeb ? '-web' : ''}',
      if (kIsWeb || !Platform.environment.containsKey('FLUTTER_TEST'))
        'X-Client-Version': packageInfo.version
    };
    if (withToken) {
      final token = await configDataSource.getAuthToken();
      if (token != null) {
        headers.addAll({
          HttpHeaders.authorizationHeader: "Bearer " + token.token,
          'X-Authorization': 'token.X-Authorization'
        });
      }
    }
    return headers;
  }

  Map<String, dynamic> _response(
      {required http.Response httpResponse,
      bool utf8Support = true,
      bool autoHandleWithStatusCode = true,
      BuildContext? context}) {
    var responseJson = _decodeResponse(utf8Support, httpResponse);
    getIt<Logger>().debug(
        "API RESPONSE -->>>> code:${httpResponse.statusCode} - ${responseJson.toString()}");
    if (!autoHandleWithStatusCode) {
      return responseJson;
    }
    switch (httpResponse.statusCode) {
      case 200:
        return responseJson;
      case 201:
        return responseJson;
      case 401:
        return responseJson;
      case 403:
        throw PermissionDeniedFailure(
            responseJson['errors'][0]['message'].toString());
      case 400:
        throw BadRequestFailure(responseJson['errors'][0]['message'].toString(),
            httpResponse.statusCode);
      case 500:
        throw InfoMessage(responseJson['errors'][0]['message'].toString());
      case 520:
        return responseJson;
      default:
        throw BadRequestFailure(responseJson['errors'][0]['message'].toString(),
            httpResponse.statusCode);
    }
  }

  _decodeResponse(bool utf8Support, response) {
    getIt<Logger>().debug(utf8.decode(response.bodyBytes));
    if (utf8Support) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      return json.decode(response.body.toString());
    }
  }

  Future<bool> _noConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.none;
  }
}
