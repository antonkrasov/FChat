import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class LoadChatEvent extends ChatEvent {
  @override
  List<Object> get props => [];
}

class NewMessageChatEvent extends ChatEvent {
  final Message message;

  NewMessageChatEvent(this.message);

  @override
  List<Object> get props => [message];
}
