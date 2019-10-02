import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class IdleLoginState extends LoginState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'IdleLoginState{}';
  }
}

class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'LoadingLoginState{}';
  }
}

class ErrorLoginState extends LoginState {
  final Exception error;

  ErrorLoginState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ErrorLoginState{$error}';
  }
}
