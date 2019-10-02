import 'package:equatable/equatable.dart';

abstract class SendmessageState extends Equatable {
  const SendmessageState();
}

class IdleSendmessageState extends SendmessageState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'IdleSendmessageState{}';
  }
}

class LoadingSendmessageState extends SendmessageState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'LoadingSendmessageState{}';
  }
}

class ErrorSendmessageState extends SendmessageState {
  final Exception error;

  ErrorSendmessageState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ErrorSendmessageState{$error}';
  }
}

class SuccessSendmessageState extends SendmessageState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'SuccessSendmessageState{}';
  }
}
