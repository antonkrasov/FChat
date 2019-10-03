import 'package:flutter/foundation.dart';

abstract class ConversationsDataProvider {
  Future<List<Map>> getConversations();

  Future<void> clearUnread({@required String fromUserID});
}
