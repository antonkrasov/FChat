import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/user.dart';

class Conversation extends Equatable {
  final FChatUser user;

  Conversation(this.user);

  @override
  List<Object> get props => [user];
}
