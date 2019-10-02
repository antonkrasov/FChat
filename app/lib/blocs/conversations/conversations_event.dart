import 'package:equatable/equatable.dart';

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
