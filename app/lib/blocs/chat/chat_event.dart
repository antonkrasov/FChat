import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/conversation.dart';
import 'package:fchat/data/model/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class LoadChatEvent extends ChatEvent {
  final Conversation conversation;

  LoadChatEvent(this.conversation);

  @override
  List<Object> get props => [conversation];

  @override
  String toString() {
    return 'LoadChatEvent{$conversation}';
  }
}

class NewMessageChatEvent extends ChatEvent {
  final Message message;

  NewMessageChatEvent(this.message);

  @override
  List<Object> get props => [message];

  @override
  String toString() {
    return 'NewMessageChatEvent{$message}';
  }
}
