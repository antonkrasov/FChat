import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fchat/data/data_provider/conversations_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConversationsDataProvider extends ConversationsDataProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  Future<List<Map>> getConversations() async {
    final currentUser = await _firebaseAuth.currentUser();
    final currentUserID = currentUser.uid;

    final usersSnapshot = await _firestore.collection('users').getDocuments();
    final users = usersSnapshot.documents.map((rawUser) {
      rawUser.data['id'] = rawUser.documentID;
      return rawUser.data;
    }).toList();

    final filteredUsers =
        users.where((rawUser) => rawUser['id'] != currentUserID).toList();

    return filteredUsers;
  }
}
