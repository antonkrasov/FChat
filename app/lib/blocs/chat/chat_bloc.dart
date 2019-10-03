import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fchat/blocs/conversations/bloc.dart';
import 'package:fchat/data/repository/chat_repository.dart';
import 'package:flutter/foundation.dart';
import './bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ConversationsBloc conversationsBloc;
  final ChatRepository chatRepository;

  ChatBloc({@required this.conversationsBloc, @required this.chatRepository});

  @override
  ChatState get initialState => LoadingChatState();

  @override
  Stream<ChatState> mapEventToState(
    ChatEvent event,
  ) async* {
    if (event is LoadChatEvent) {
      yield* _handleLoadChatEvent(event);
    } else if (event is NewMessageChatEvent) {
      yield* _handleNewMessageChatEvent(event);
    }
  }

  Stream<ChatState> _handleLoadChatEvent(LoadChatEvent event) async* {
    yield LoadingChatState();

    try {
      final messages = await chatRepository.getMessages(event.conversation);
      yield IdleChatState(messages);
    } catch (ex) {
      yield ErrorChatState(ex);
    }
  }

  _handleNewMessageChatEvent(NewMessageChatEvent event) {}
}
