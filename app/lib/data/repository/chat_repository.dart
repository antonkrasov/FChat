import 'package:fchat/data/data_provider/chat_data_provider.dart';
import 'package:fchat/data/model/conversation.dart';
import 'package:fchat/data/model/message.dart';
import 'package:fchat/data/model/user.dart';
import 'package:flutter/foundation.dart';

class ChatRepository {
  final ChatDataProvider chatDataProvider;

  ChatRepository(this.chatDataProvider);

  Future<List<Message>> getMessages(Conversation conversation) async {
    final rawMessages =
        await chatDataProvider.getMessages(conversationId: conversation.id);

    final messages = rawMessages
        .map(
          (rawMessage) => Message.fromMap(rawMessage),
        )
        .toList();

    return messages;
  }

  Future<void> sendMessage({
    @required FChatUser to,
    @required FChatUser from,
    @required String text,
  }) async {
    await chatDataProvider.sendMessage(
      toId: to.id,
      toName: to.name,
      fromId: from.id,
      fromName: from.name,
      text: text,
    );
  }
}
