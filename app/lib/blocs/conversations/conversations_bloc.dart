import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fchat/blocs/user/bloc.dart';
import 'package:fchat/blocs/user/user_bloc.dart';
import 'package:fchat/data/repository/conversations_repository.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final ConversationsRepository conversationsRepository;
  final UserBloc userBloc;

  StreamSubscription _userStateSubscription;

  ConversationsBloc({this.conversationsRepository, this.userBloc}) {
    _userStateSubscription = userBloc.state.listen((state) {
      if (state is LoggedInUserState) {
        dispatch(LoadConversationsEvent());
      }
    });
  }

  @override
  void dispose() {
    _userStateSubscription.cancel();
    super.dispose();
  }

  @override
  ConversationsState get initialState => LoadingConversationsState();

  @override
  Stream<ConversationsState> mapEventToState(
    ConversationsEvent event,
  ) async* {
    if (event is LoadConversationsEvent) {
      yield* _handleLoadConversationsEvent();
    } else if (event is MessagesReadConversationsEvent) {
      yield* _handleMessagesReadConversationsEvent(event);
    }
  }

  Stream<ConversationsState> _handleLoadConversationsEvent() async* {
    yield LoadingConversationsState();

    try {
      final conversations = await conversationsRepository.getConversations();
      yield IdleConversationsState(conversations);
    } catch (ex) {
      yield ErrorConversationsState(ex);
    }
  }

  Stream<ConversationsState> _handleMessagesReadConversationsEvent(
    MessagesReadConversationsEvent event,
  ) async* {
    // 1. clear unread messages for this conversation...
    final messages = event.messages;
    if (messages.isNotEmpty) {
      // let's find first message not from current user
      var fromId;
      for (var message in messages) {
        if (!message.isFromUser) {
          fromId = message.from.id;
          break;
        }
      }

      await conversationsRepository.conversationsDataProvider.clearUnread(
        fromUserID: fromId,
      );

      // 2. Update current state with new unread count...
      final state = currentState;
      if (state is IdleConversationsState) {
        final conversations = state.conversations;

        final currentConversation = conversations
            .firstWhere((conversation) => conversation.id == fromId);
        conversations.removeWhere((conversation) => conversation.id == fromId);

        yield IdleConversationsState(
          [currentConversation.copyWith(unreadMessages: 0)]
            ..addAll(conversations),
        );
      }
    }
  }
}
