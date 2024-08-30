import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/core/utils/services/logger/logger.dart';

initializeAppmetrica() {
  AppMetrica.activate(
    AppMetricaConfig(
      dotenv.env["APPMETRICA_API_KEY"]!,
      logs: true,
      crashReporting: true,
      nativeCrashReporting: true,
    ),
  );
}

@singleton
class AppMetricaAnalytic {
  reportEvent(AnalyticEvents? event) {
    getIt<Logger>().debug(event!.text, title: 'Analytics event: ');
    AppMetrica.reportEvent(event.text);
  }
}

extension AnalyticEventExtension on AnalyticEvents {
  String get text {
    switch (this) {
      // pages
      case AnalyticEvents.MAIN_PAGE:
        return "main_page";
    }
  }
}

enum AnalyticEvents {
  // pages
  MAIN_PAGE,
}
