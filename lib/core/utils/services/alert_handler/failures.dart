
import 'package:equatable/equatable.dart';

enum AlertType { FAILURE, INFO }

abstract class Alert extends Equatable {
  final message;
  final AlertType type;
  final code;

  Alert(this.message, {this.code = 400, required this.type});

    @override
    String toString() {
        return message;
    }
}

class InfoMessage extends Alert {
  InfoMessage(message) : super(message, type: AlertType.INFO);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

abstract class Failure extends Alert {
  Failure(message, {code = 400})
      : super(message, code: code, type: AlertType.FAILURE);
}

class ServerFailure extends Failure {
  ServerFailure(message) : super(message, code: 500);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class BadRequestFailure extends Failure {
  BadRequestFailure(message, code) : super(message, code: code);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class UnAuthorizedFailure extends Failure {
  UnAuthorizedFailure(message) : super(message, code: 401);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class PermissionDeniedFailure extends Failure {
  PermissionDeniedFailure(message) : super(message, code: 403);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class FetchDataFailure extends Failure {
  FetchDataFailure(message) : super(message);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class AccessDeniedFailure extends Failure {
  AccessDeniedFailure(message) : super(message);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class AppFailure extends Failure {
  AppFailure(message) : super(message);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class WrongPasswordFailure extends Failure {
  WrongPasswordFailure(message) : super(message);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class DatabaseFailure extends Failure {
  DatabaseFailure(message) : super(message);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class NoConnectionToInternetFailure extends Failure {
  NoConnectionToInternetFailure(message) : super(message);
  
  @override
  List<Object?> get props => [this.code, this.message];
}

class GeneralFailure extends Failure {
  GeneralFailure(message) : super(message);
  
  @override
  List<Object?> get props => [this.code, this.message];
}