import 'package:flutter/foundation.dart';

abstract class ChatDataProvider {
  Stream<List<Map>> messages({@required String conversationId});

  Future<void> sendMessage(
      {String toId,
      String toName,
      String fromId,
      String fromName,
      String text});
}
