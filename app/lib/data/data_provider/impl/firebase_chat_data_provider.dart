import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fchat/data/data_provider/chat_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseChatDataProvider extends ChatDataProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  Future<List<Map>> getMessages({String conversationId}) {
    return null;
  }

  @override
  Future<void> sendMessage({
    String toId,
    String toName,
    String fromId,
    String fromName,
    String text,
  }) async {
    await _firestore.collection('messages').document().setData({
      'to_id': toId,
      'to_name': toName,
      'from_id': fromId,
      'from_name': fromName,
      'text': text,
      'date': FieldValue.serverTimestamp()
    });
  }
}
