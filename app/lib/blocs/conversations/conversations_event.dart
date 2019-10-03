import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/message.dart';

abstract class ConversationsEvent extends Equatable {
  const ConversationsEvent();
}

class LoadConversationsEvent extends ConversationsEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'LoadConversationsEvent{}';
  }
}

class MessagesReadConversationsEvent extends ConversationsEvent {
  final List<Message> messages;

  MessagesReadConversationsEvent(this.messages);

  @override
  List<Object> get props => [messages];

  @override
  String toString() {
    return 'MessagesReadConversationsEvent{$messages}';
  }
}
