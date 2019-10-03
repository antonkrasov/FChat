import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fchat/blocs/conversations/bloc.dart';
import 'package:fchat/data/model/conversation.dart';
import 'package:fchat/data/model/message.dart';
import 'package:fchat/data/repository/chat_repository.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ConversationsBloc conversationsBloc;
  final ChatRepository chatRepository;

  StreamSubscription<List<Message>> _messagesStreamSubscription;

  ChatBloc({
    @required this.conversationsBloc,
    @required this.chatRepository,
    Conversation conversation,
  }) {
    _messagesStreamSubscription = chatRepository
        .messages(conversation)
        .listen((messages) => dispatch(UpdateMessagesChatEvent(messages)));
  }

  @override
  void dispose() {
    _messagesStreamSubscription.cancel();
    super.dispose();
  }

  @override
  ChatState get initialState => LoadingChatState();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is UpdateMessagesChatEvent) {
      // let's notify converstions Bloc about new messages,
      // we need to remove unread badge count, etc...
      conversationsBloc.dispatch(
        MessagesReadConversationsEvent(event.messages),
      );

      yield IdleChatState(event.messages);
    }
  }
}
