import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/message.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class LoadingChatState extends ChatState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'LoadingChatState{}';
  }
}

class IdleChatState extends ChatState {
  final List<Message> messages;

  IdleChatState(this.messages);

  @override
  List<Object> get props => [messages];

  @override
  String toString() {
    return 'IdleChatState{}';
  }
}

class ErrorChatState extends ChatState {
  final Exception error;

  ErrorChatState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ErrorChatState{}';
  }
}
