import 'package:flutter/material.dart';
import 'package:spotify/core/utils/services/appmetrica/appmetrica_service.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/src/base/presentation/pages/page_wrapper.dart';

class MainPage extends StatefulWidget {
  static const String id = 'MainPage';

  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends PageWrapper<MainPage> {
  @override
  void initState() {
    getIt<AppMetricaAnalytic>().reportEvent(AnalyticEvents.MAIN_PAGE);
    super.initState();
  }

  @override
  Widget buildPage(BuildContext context) {
    return Container();
  }
}
