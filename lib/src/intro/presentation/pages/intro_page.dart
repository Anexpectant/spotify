import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/utils/services/appmetrica/appmetrica_service.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/src/base/presentation/pages/page_wrapper.dart';

@injectable
class IntroPage extends StatefulWidget {
  static const String id = 'IntroPage';

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends PageWrapper<IntroPage> {
  @override
  void initState() {
    getIt<AppMetricaAnalytic>().reportEvent(AnalyticEvents.INTRO_PAGE);
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Container();
  }
}
