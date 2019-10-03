import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/user.dart';

class Message extends Equatable {
  final FChatUser from;
  final FChatUser to;
  final String text;
  final bool isFromUser;
  final DateTime time;

  Message({this.from, this.to, this.text, this.isFromUser, this.time});

  @override
  List<Object> get props => [from, to, text, isFromUser];

  factory Message.fromMap(Map rawMessage) {
    final rawFromUser = {
      'id': rawMessage['from_id'],
      'name': rawMessage['from_name'],
    };

    final rawToUser = {
      'id': rawMessage['to_id'],
      'name': rawMessage['to_name'],
    };

    return Message(
      from: FChatUser.fromMap(rawFromUser),
      to: FChatUser.fromMap(rawToUser),
      text: rawMessage['text'],
      isFromUser: rawMessage['is_from_user'],
      time: rawMessage['date']?.toDate(),
    );
  }
}