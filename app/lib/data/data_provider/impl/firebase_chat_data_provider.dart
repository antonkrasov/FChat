import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fchat/data/data_provider/chat_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseChatDataProvider extends ChatDataProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  String _buildConversationId(first, second) {
    final ids = [first, second];
    ids.sort((a, b) => a.compareTo(b));
    return '${ids[0]}:${ids[1]}';
  }

  @override
  Future<void> sendMessage({
    String toId,
    String toName,
    String fromId,
    String fromName,
    String text,
  }) async {
    final conversationId = _buildConversationId(toId, fromId);

    await _firestore.collection('messages').document().setData({
      'conversation_id': conversationId,
      'to_id': toId,
      'to_name': toName,
      'from_id': fromId,
      'from_name': fromName,
      'text': text,
      'date': FieldValue.serverTimestamp()
    });
  }

  @override
  Stream<List<Map>> messages({String conversationId}) async* {
    final currentUser = await _firebaseAuth.currentUser();
    final currentUserID = currentUser.uid;

    yield* _firestore
        .collection('messages')
        .where(
          'conversation_id',
          isEqualTo: _buildConversationId(currentUserID, conversationId),
        )
        .snapshots()
        .map((snapshot) {
      return snapshot.documents.map((rawMessage) {
        rawMessage.data['id'] = rawMessage.documentID;
        rawMessage.data['is_from_user'] =
            rawMessage.data['from_id'] == currentUserID;
        return rawMessage.data;
      }).toList();
    });
  }
}
