abstract class ChatDataProvider {
  Future<List<Map>> getMessages({String conversationId});

  Future<void> sendMessage(
      {String toId,
      String toName,
      String fromId,
      String fromName,
      String text});
}
