import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:oktoast/oktoast.dart';
import 'package:spotify/core/styles/themes.dart';
import 'package:spotify/core/utils/scroll_behavior/custom_scroll_behavior.dart';
import 'package:spotify/core/utils/services/alert_handler/alert_handler_cubit.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/core/utils/services/localization/languages.dart';
import 'package:spotify/core/utils/services/logger/logger.dart';
import 'package:spotify/core/utils/services/navigation/route_and_navigation_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/src/splash/domain/bloc/initializer_cubit.dart';
import 'package:spotify/src/splash/presentation/pages/splash_page.dart';

@injectable
class ApplicationEntry extends StatefulWidget {
  @override
  State<ApplicationEntry> createState() => _ApplicationEntryState();
}

class _ApplicationEntryState extends State<ApplicationEntry> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getIt<AlertHandlerCubit>(),
          ),
          BlocProvider.value(value: getIt<InitializerCubit>()),
        ],
        child: MaterialApp(
          title: 'اسپاتیفای',
          onGenerateRoute: generateRoute,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: Languages.localizationsDelegates,
          supportedLocales: Languages.supportedLocales,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: AppTheme.lightTheme,
          locale: Locale('fa'),
          builder: (BuildContext context, Widget? widget) {
            getIt<Logger>()
                .debug(widget.toString(), title: 'material builder issue');
            if (widget == null) return Container();
            return OKToast(
              textAlign: TextAlign.start,
              textDirection: Directionality.of(context),
              dismissOtherOnShow: true,
              position: ToastPosition.top,
              child: widget,
            );
          },
          home: const SplashPage(),
        ));
  }
}
