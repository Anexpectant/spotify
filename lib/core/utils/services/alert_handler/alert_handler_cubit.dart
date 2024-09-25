import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:spotify/core/utils/services/alert_handler/failures.dart';

part 'alert_handler_state.dart';

@singleton
class AlertHandlerCubit extends Cubit<AlertHandlerState> {
  AlertHandlerCubit() : super(FailureFreeState());

  raise(Alert failure, {int duration = 1}) async {
    emit(FailureOccurred(failure));
    await Future.delayed(Duration(seconds: duration));
    emit(FailureFreeState());
  }

  info(Alert message, {int duration = 1}) async {
    emit(InfoState(message));
    await Future.delayed(Duration(seconds: duration));
    emit(FailureFreeState());
  }
}
