import 'package:flutter/material.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/src/intro/presentation/pages/intro_page.dart';
import 'package:spotify/src/main/presentation/pages/main_page.dart';
import 'package:spotify/src/sign_in/presentation/pages/sign_in_page.dart';
import 'package:spotify/src/splash/presentation/pages/splash_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  return _routes(settings.arguments)[settings.name]!;
}

Map<String, MaterialPageRoute<dynamic>> _routes(args) => {
      IntroPage.id: MaterialPageRoute(builder: (context) => getIt<IntroPage>()),
      SplashPage.id:
          MaterialPageRoute(builder: (context) => const SplashPage()),
      SignInPage.id:
          MaterialPageRoute(builder: (context) => getIt.get<SignInPage>()),
      MainPage.id: MaterialPageRoute(builder: (context) => getIt<MainPage>()),
    };
