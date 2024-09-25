part of 'alert_handler_cubit.dart';

@immutable
abstract class AlertHandlerState extends Equatable {}

class FailureFreeState extends AlertHandlerState {
  @override
  List<Object?> get props => [];
}

class FailureOccurred extends AlertHandlerState {
  final Alert failure;

  FailureOccurred(this.failure);

  @override
  List<Object?> get props => [failure.message];
}

class InfoState extends AlertHandlerState {
  final Alert message;

  InfoState(this.message);

  @override
  List<Object?> get props => [message.message];
}
