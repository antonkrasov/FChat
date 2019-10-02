import 'package:fchat/data/data_provider/conversations_data_provider.dart';
import 'package:fchat/data/model/conversation.dart';
import 'package:fchat/data/model/user.dart';

class ConversationsRepository {
  final ConversationsDataProvider conversationsDataProvider;

  ConversationsRepository(this.conversationsDataProvider);

  Future<List<Conversation>> getConversations() async {
    final rawUsers = await conversationsDataProvider.getConversations();

    final conversations = rawUsers.map((rawUser) {
      final user = FChatUser.fromMap(rawUser);

      final conversation = Conversation(user);
      return conversation;
    }).toList();

    return conversations;
  }
}
