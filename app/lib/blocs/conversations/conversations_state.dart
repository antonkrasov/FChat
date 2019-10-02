import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/conversation.dart';

abstract class ConversationsState extends Equatable {
  const ConversationsState();
}

class LoadingConversationsState extends ConversationsState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'LoadingConversationsState{}';
  }
}

class IdleConversationsState extends ConversationsState {
  final List<Conversation> conversations;

  IdleConversationsState(this.conversations);

  @override
  List<Object> get props => [conversations];

  @override
  String toString() {
    return 'IdleConversationsState{$conversations}';
  }
}

class ErrorConversationsState extends ConversationsState {
  final Exception error;

  ErrorConversationsState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ErrorConversationsState{$error}';
  }
}
