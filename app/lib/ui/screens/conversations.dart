import 'package:fchat/blocs/conversations/bloc.dart';
import 'package:fchat/data/model/conversation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final conversationsBloc = BlocProvider.of<ConversationsBloc>(context);

    return BlocBuilder(
      bloc: conversationsBloc,
      builder: (context, state) => _build(state),
    );
  }

  _build(state) {
    if (state is LoadingConversationsState) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (state is ErrorConversationsState) {
      final error = state.error;
      return Center(
        child: Text('$error'),
      );
    }

    if (state is IdleConversationsState) {
      final conversations = state.conversations;
      return ListView.builder(
        itemCount: conversations.length,
        padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        itemBuilder: (context, position) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: ConversationTile(
            conversation: conversations[position],
          ),
        ),
      );
    }
  }
}

class ConversationTile extends StatelessWidget {
  final Conversation conversation;

  const ConversationTile({Key key, this.conversation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          'chat',
          arguments: conversation,
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 52,
                width: 52,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 100, 54, 132),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    conversation.user.name[0],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(
                  conversation.user.name,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
