import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();
}

class UpdateMessagesChatEvent extends ChatEvent {
  final List<Message> messages;

  UpdateMessagesChatEvent(this.messages);

  @override
  List<Object> get props => [messages];

  @override
  String toString() {
    return 'UpdateMessagesChatEvent{$messages}';
  }
}
