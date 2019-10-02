import 'package:fchat/blocs/chat/bloc.dart';
import 'package:fchat/blocs/conversations/bloc.dart';
import 'package:fchat/blocs/sendmessage/bloc.dart';
import 'package:fchat/blocs/sendmessage/sendmessage_bloc.dart';
import 'package:fchat/blocs/user/bloc.dart';
import 'package:fchat/data/data_provider/impl/firebase_chat_data_provider.dart';
import 'package:fchat/data/model/conversation.dart';
import 'package:fchat/data/repository/chat_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  final Conversation conversation;

  const ChatScreen({Key key, @required this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    final conversationsBloc = BlocProvider.of<ConversationsBloc>(context);

    final chatDataProvider = FirebaseChatDataProvider();
    final chatRepository = ChatRepository(chatDataProvider);

    final chatBloc = ChatBloc(
        chatRepository: chatRepository, conversationsBloc: conversationsBloc);
    final sendmessageBloc =
        SendmessageBloc(chatBloc: chatBloc, userBloc: userBloc);

    return Scaffold(
      appBar: AppBar(
        title: Text(this.conversation.user.name),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<ChatBloc>(
            builder: (context) => chatBloc,
          ),
          BlocProvider<SendmessageBloc>(
            builder: (context) => sendmessageBloc,
          ),
        ],
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: ChatList(),
              ),
              InputMessageBox(
                conversation: this.conversation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatBloc = BlocProvider.of<ChatBloc>(context);

    return BlocBuilder(
      bloc: chatBloc,
      builder: (context, state) => _build(state),
    );
  }

  _build(state) {
    if (state is LoadingChatState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ErrorChatState) {
      final error = state.error;
      return Center(
        child: Text('$error'),
      );
    }

    if (state is IdleChatState) {
      final messages = state.messages;
      return ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, position) {
          return ChatMessage(
            text: messages[position].text,
            fromUser: messages[position].isFromUser,
          );
        },
      );
    }
  }
}

class InputMessageBox extends StatefulWidget {
  final Conversation conversation;

  const InputMessageBox({Key key, @required this.conversation})
      : super(key: key);

  @override
  _InputMessageBoxState createState() => _InputMessageBoxState();
}

class _InputMessageBoxState extends State<InputMessageBox> {
  TextEditingController _messageTextController;

  @override
  void initState() {
    super.initState();
    _messageTextController = TextEditingController();
  }

  @override
  void dispose() {
    _messageTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sendmessageBloc = BlocProvider.of<SendmessageBloc>(context);

    return BlocListener(
      bloc: sendmessageBloc,
      listener: (context, state) {
        if (state is SuccessSendmessageState) {
          _messageTextController.clear();
        }
      },
      child: BlocBuilder(
        bloc: sendmessageBloc,
        builder: (context, state) => _build(state),
      ),
    );
  }

  _build(state) {
    if (state is LoadingSendmessageState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ErrorSendmessageState) {
      final error = state.error;
      return Center(
        child: Text('$error'),
      );
    }

    if (state is IdleSendmessageState) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _messageTextController,
                decoration: InputDecoration(
                  hintText: 'Message',
                ),
              ),
            ),
            SizedBox(
              width: 16,
            ),
            _buildSendButton()
          ],
        ),
      );
    }
  }

  _buildSendButton() {
    return GestureDetector(
      onTap: () {
        final sendmessageBloc = BlocProvider.of<SendmessageBloc>(context);
        sendmessageBloc.dispatch(SendmessageEvent(
            to: this.widget.conversation.user,
            text: _messageTextController.text));
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: Colors.teal,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final bool fromUser;

  const ChatMessage({Key key, this.text, this.fromUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color =
        fromUser ? Colors.blue.withOpacity(0.3) : Colors.teal.withOpacity(0.3);

    return Card(
      color: color,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(this.text),
      ),
    );
  }
}
