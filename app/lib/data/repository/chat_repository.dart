import 'package:fchat/data/data_provider/chat_data_provider.dart';
import 'package:fchat/data/model/conversation.dart';
import 'package:fchat/data/model/message.dart';
import 'package:fchat/data/model/user.dart';
import 'package:flutter/foundation.dart';

class ChatRepository {
  final ChatDataProvider chatDataProvider;

  ChatRepository(this.chatDataProvider);

  Stream<List<Message>> messages(Conversation conversation) async* {
    yield* chatDataProvider
        .messages(conversationId: conversation.id)
        .map((rawMessages) {
      final messages = rawMessages
          .map(
            (rawMessage) => Message.fromMap(rawMessage),
          )
          .toList();

      // TODO: better implementation...
      messages.sort((a, b) {
        if (a.time == null && b.time == null) {
          return 0;
        }

        if (a.time == null) {
          return -1;
        }

        if (b.time == null) {
          return 1;
        }

        return a.time.compareTo(b.time);
      });
      return messages;
    });
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
