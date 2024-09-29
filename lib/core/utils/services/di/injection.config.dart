// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:spotify/application_entry.dart' as _i745;
import 'package:spotify/core/utils/services/alert_handler/alert_handler_cubit.dart'
    as _i570;
import 'package:spotify/core/utils/services/appmetrica/appmetrica_service.dart'
    as _i787;
import 'package:spotify/core/utils/services/logger/logger.dart' as _i228;
import 'package:spotify/src/base/data/data_sources/base_local_data_source.dart'
    as _i801;
import 'package:spotify/src/base/data/data_sources/config_local_data_source.dart'
    as _i1021;
import 'package:spotify/src/base/data/data_sources/user_local_data_source.dart'
    as _i666;
import 'package:spotify/src/intro/presentation/pages/intro_page.dart' as _i621;

const String _dev = 'dev';

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.factory<_i801.LocalDataSource>(
    () => _i801.LocalDataSource(),
    registerFor: {_dev},
  );
  gh.factory<_i745.ApplicationEntry>(() => _i745.ApplicationEntry());
  gh.factory<_i621.IntroPage>(() => _i621.IntroPage());
  gh.singleton<_i570.AlertHandlerCubit>(() => _i570.AlertHandlerCubit());
  gh.singleton<_i787.AppMetricaAnalytic>(() => _i787.AppMetricaAnalytic());
  gh.singleton<_i228.Logger>(() => _i228.Logger());
  gh.factory<_i1021.ConfigLocalDataSource>(
    () => _i1021.ConfigLocalDataSource(),
    registerFor: {_dev},
  );
  gh.singleton<_i666.BaseUserLocalDataSource>(
    () => _i666.BaseUserLocalDataSource(),
    registerFor: {_dev},
  );
  return getIt;
}
