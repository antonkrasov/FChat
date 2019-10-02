import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/user.dart';

class Conversation extends Equatable {
  final String id;
  final FChatUser user;

  Conversation(this.id, this.user);

  @override
  List<Object> get props => [user];
}
