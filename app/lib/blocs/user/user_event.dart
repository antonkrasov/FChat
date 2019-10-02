import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/user.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class AppStartedEvent extends UserEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'AppStartedEvent{}';
  }
}

class LoggedInEvent extends UserEvent {
  final FChatUser fChatUser;

  LoggedInEvent(this.fChatUser);

  @override
  List<Object> get props => [fChatUser];

  @override
  String toString() {
    return 'LoggedInEvent{$fChatUser}';
  }
}
