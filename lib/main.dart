import 'package:flutter/material.dart';
import 'package:spotify/application_entry.dart';
import 'package:spotify/core/utils/services/appmetrica/appmetrica_service.dart';
import 'package:spotify/core/utils/services/di/injection.dart';
import 'package:spotify/core/utils/services/env_variables/env_variables.dart';
import 'package:spotify/core/utils/services/local_db/hive/hive_db.dart';

void main() async {
  await startUp();
  runApp(getIt<ApplicationEntry>());
}

startUp() async {
  await initializeDotEnv();
  initializeAppmetrica();
  initHive();
  configureDependencies();
}