import 'package:flutter_dotenv/flutter_dotenv.dart';

initializeDotEnv() async {
  await dotenv.load(fileName: ".env");
}