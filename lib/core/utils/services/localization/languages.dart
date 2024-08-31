import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

part 'language_en.dart';

part 'language_fa.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'fa'].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case 'en':
        return LanguageEn();
      case 'fa':
        return LanguageFa();
      default:
        return LanguageFa();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}

abstract class Languages {
  static final Languages defaultLanguage = LanguageFa();

  static Languages of(BuildContext? context) {
    if (context != null) {
      return Localizations.of<Languages>(context, Languages)!;
    }
    return defaultLanguage;
  }

  static const LocalizationsDelegate<Languages> delegate =
      AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fa')
  ];

  // ------------- general
  String get appName;
}
