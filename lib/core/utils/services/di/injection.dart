import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/utils/services/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: r'$initGetIt',
    preferRelativeImports: false,
    asExtension: false)
void configureDependencies() => $initGetIt(getIt, environment: Environment.dev);
void configureTestDependencies() =>
    $initGetIt(getIt, environment: Environment.test);
