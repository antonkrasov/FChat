import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

const MESSAGES = [
  {'text': 'Message 1', 'from_user': false},
  {'text': 'Message 2', 'from_user': true},
  {'text': 'Message 3', 'from_user': false},
];

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: Center(
        child: SafeArea(
          child: Column(
            children: <Widget>[_buildList(), InputMessageBox()],
          ),
        ),
      ),
    );
  }

  _buildList() {
    return Expanded(
      child: ListView.builder(
        reverse: true,
        itemCount: MESSAGES.length,
        itemBuilder: (context, position) {
          final text = MESSAGES[position]['text'];
          final fromUser = MESSAGES[position]['from_user'];

          return Padding(
            padding: EdgeInsets.only(
              left: fromUser ? 60 : 0,
              right: fromUser ? 0 : 60,
            ),
            child: ChatMessage(
              text: text,
              fromUser: fromUser,
            ),
          );
        },
      ),
    );
  }
}

class InputMessageBox extends StatefulWidget {
  @override
  _InputMessageBoxState createState() => _InputMessageBoxState();
}

class _InputMessageBoxState extends State<InputMessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Message',
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          Container(
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
          )
        ],
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
