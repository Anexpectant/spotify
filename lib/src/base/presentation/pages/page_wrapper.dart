import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {super.key,
      required this.desktop,
      required this.largeMobile,
      required this.mobile,
      required this.tablet,
      this.extraLargeScreen});
  final Widget desktop;
  final Widget? largeMobile;
  final Widget mobile;
  final Widget? tablet;
  final Widget? extraLargeScreen;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 500;
  }

  static bool isLargeMobile(BuildContext context) {
    return MediaQuery.of(context).size.width > 500 &&
        MediaQuery.of(context).size.width <= 700;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width > 700 &&
        MediaQuery.of(context).size.width <= 1024;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width > 1024 &&
        MediaQuery.of(context).size.width <= 1400;
  }

  static bool isExtraLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1400;
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isExtraLargeScreen(context) && extraLargeScreen != null) {
      return extraLargeScreen!;
    } else if (Responsive.isDesktop(context)) {
      return desktop;
    } else if (Responsive.isTablet(context) && tablet != null) {
      return tablet!;
    } else if (Responsive.isLargeMobile(context) && largeMobile != null) {
      return largeMobile!;
    } else {
      return mobile;
    }
  }
}
