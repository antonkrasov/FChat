import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/user.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UninitializedUserState extends UserState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'UninitializedUserState{}';
  }
}

class LoginRequiredUserState extends UserState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'LoginRequiredUserState{}';
  }
}

class LoggedInUserState extends UserState {
  final FChatUser fChatUser;

  LoggedInUserState(this.fChatUser);

  @override
  List<Object> get props => [fChatUser];

  @override
  String toString() {
    return 'LoggedInUserState{$fChatUser}';
  }
}
