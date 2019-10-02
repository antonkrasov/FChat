import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fchat/blocs/chat/chat_bloc.dart';
import 'package:fchat/blocs/user/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class SendmessageBloc extends Bloc<SendmessageEvent, SendmessageState> {
  final UserBloc userBloc;
  final ChatBloc chatBloc;

  SendmessageBloc({@required this.chatBloc, @required this.userBloc});

  @override
  SendmessageState get initialState => IdleSendmessageState();

  @override
  Stream<SendmessageState> mapEventToState(
    SendmessageEvent event,
  ) async* {
    yield LoadingSendmessageState();

    try {
      final currentUser = userBloc.getCurrentUser();
      await chatBloc.chatRepository.sendMessage(
        to: event.to,
        from: currentUser,
        text: event.text,
      );

      yield SuccessSendmessageState();
      yield IdleSendmessageState();
    } catch (ex) {
      yield ErrorSendmessageState(ex);
    }
  }
}
