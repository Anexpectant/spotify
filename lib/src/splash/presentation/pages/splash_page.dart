import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive/hive.dart';
import 'package:spotify/core/constants/assets.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/core/utils/services/logger/logger.dart';
import 'package:spotify/src/base/data/data_sources/base_local_data_source.dart';
import 'package:spotify/src/base/data/data_sources/user_local_data_source.dart';
import 'package:spotify/src/base/data/models/token.dart';
import 'package:spotify/src/base/presentation/pages/page_wrapper.dart';
import 'package:spotify/src/splash/domain/bloc/initializer_cubit.dart';

class SplashPage extends StatefulWidget {
  static const String id = 'SplashPage';
  final Token? initialToken;

  const SplashPage({super.key, this.initialToken});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    BaseUserLocalDataSource()..init();

    if (widget.initialToken != null) {
      getIt<LocalDataSource>().setAuthToken(widget.initialToken!);
    }
    Future.delayed(const Duration(milliseconds: 500));
    getIt<InitializerCubit>().exec();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InitializerCubit, InitializerState>(
      listener: (BuildContext context, state) {
        getIt<Logger>().debug(state.toString(), title: 'splash listener');

        if (state is InitializeSuccess) {
          Navigator.of(context).popUntil((route) => route.isFirst);
          Navigator.pushReplacementNamed(context, state.pageId,
              arguments: true);
        }
      },
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.red,
          child:  Center(
            child: SvgPicture.asset(
              Assets.IC_SPLASH_LOGO,
              width: MediaQuery.of(context).size.width *
                  (Responsive.isMobile(context) ? 0.3 : 0.6),
              height: MediaQuery.of(context).size.height *
                  (Responsive.isMobile(context) ? 0.3 : 0.6),

              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
