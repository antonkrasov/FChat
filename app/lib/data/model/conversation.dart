import 'package:equatable/equatable.dart';
import 'package:fchat/data/model/user.dart';

class Conversation extends Equatable {
  final String id;
  final FChatUser user;
  final int unreadMessages;

  Conversation(this.id, this.user, this.unreadMessages);

  @override
  List<Object> get props => [id, user, unreadMessages];

  @override
  String toString() {
    return 'Conversation{$user, unread: $unreadMessages}';
  }

  static String buildId(String firstId, String secondId) {
    final ids = [firstId, secondId];
    ids.sort((a, b) => a.compareTo(b));
    return '${ids[0]}:${ids[1]}';
  }

  Conversation copyWith({int unreadMessages}) {
    return Conversation(this.id, this.user, unreadMessages);
  }
}
