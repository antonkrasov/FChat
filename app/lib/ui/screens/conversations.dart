import 'package:flutter/material.dart';

const ITEMS = [
  'TEST 1',
  'TEST 2',
  'Anton Krasov',
  'Ipad Test',
];

class ConversationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ITEMS.length,
      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      itemBuilder: (context, position) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: ConversationTile(
          name: ITEMS[position],
        ),
      ),
    );
  }
}

class ConversationTile extends StatelessWidget {
  final String name;

  const ConversationTile({Key key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('chat');
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
                    name[0],
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
                  this.name,
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
