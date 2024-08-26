import 'package:injectable/injectable.dart';

enum LogMode { ERROR, DEBUG, INFO }

@singleton
class Logger {
  LogMode? mode;
  bool mute = false;

  Logger();

  _consolePrint(String msg, {required String title}) {
    print('----------> $title: $msg');
  }

  debug(String msg, {String? title}) {
    if (!mute) _consolePrint(msg, title: title ?? 'debug print');
  }

  info(String msg, {String? title}) {
    if (!mute) _consolePrint(msg, title: title ?? 'info print');
  }
}
