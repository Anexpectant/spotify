part of 'initializer_cubit.dart';

@immutable
abstract class InitializerState extends Equatable {}

class InitialState extends InitializerState {
  @override
  List<Object> get props => ['InitialState'];
}

class InitializeSuccess extends InitializerState {
  final String pageId;
  final String? childId;

  InitializeSuccess(this.pageId, {this.childId});

  @override
  List<Object> get props => [pageId];
}
