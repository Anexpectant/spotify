import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/core/utils/services/logger/logger.dart';
import 'package:spotify/src/base/data/models/token.dart';

@Injectable(env: [Environment.dev], order: -1)
class LocalDataSource {
  final String tokenBoxName = 'tokenBox';

  init() async {
    final watch = Stopwatch()..start();
    await exec();
    getIt<Logger>().debug('elapsed time of init: ${watch.elapsed.inSeconds}');
  }

  exec() {}

  Future<Uint8List?> getStorageKey() async {
    if (kIsWeb) return null;
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    var containsEncryptionKey = await secureStorage.containsKey(key: 'key');
    if (!containsEncryptionKey) {
      var key = Hive.generateSecureKey();
      await secureStorage.write(key: 'key', value: base64UrlEncode(key));
    }
    String? encodedKey = await secureStorage.read(key: 'key');
    Uint8List encryptionKey = base64Url.decode(encodedKey!);
    return encryptionKey;
  }

  Future<Box<T>> openEncryptedBox<T>(String boxName) async {
    if (kIsWeb) return Future.value(Hive.openBox<T>(boxName));
    return Future.value(Hive.openBox<T>(boxName,
        encryptionCipher: HiveAesCipher((await getStorageKey())!)));
  }

  Future<Token?> getAuthToken() async {
    final configBox = await openEncryptedBox<Token?>(tokenBoxName);
    return configBox.get('authToken', defaultValue: null);
  }

  setAuthToken(Token? token) async {
    final configBox = await openEncryptedBox<Token?>(tokenBoxName);
    await configBox.put('authToken', token);
  }
}
