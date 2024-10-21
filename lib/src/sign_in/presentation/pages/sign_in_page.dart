import 'package:flutter/material.dart';
import 'package:spotify/core/utils/services/appmetrica/appmetrica_service.dart';
import 'package:spotify/core/utils/services/di/injection.dart';

class SignInPage extends StatefulWidget {
  static const String id = 'SignInPage';

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    getIt<AppMetricaAnalytic>().reportEvent(AnalyticEvents.SIGN_IN_PAGE);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Colors.blue,
    );
  }
}
