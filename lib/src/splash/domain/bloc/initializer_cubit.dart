import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/core/utils/services/logger/logger.dart';
import 'package:spotify/src/base/data/data_sources/base_local_data_source.dart';
import 'package:spotify/src/base/data/data_sources/config_local_data_source.dart';
import 'package:spotify/src/intro/presentation/pages/intro_page.dart';
import 'package:spotify/src/main/presentation/pages/main_page.dart';
import 'package:spotify/src/sign_in/presentation/pages/sign_in_page.dart';

part 'initializer_state.dart';

@singleton
class InitializerCubit extends Cubit<InitializerState> {
  InitializerCubit() : super(InitialState());

  Future<String> getBasePage() async {
    final authToken = await getIt<LocalDataSource>().getAuthToken();

    getIt<Logger>().info(authToken.toString(), title: 'authToken');
    await Future.delayed(const Duration(milliseconds: 500));
    final seenState = await getIt<ConfigLocalDataSource>().getIntroSeenState();
    if (authToken == null && !seenState)
      return IntroPage.id;
    else if (authToken == null && seenState)
      return SignInPage.id;
    else
      return MainPage.id;
  }

  exec() async {
    emit(InitialState());

    emit(InitializeSuccess(await getBasePage()));
  }
}
