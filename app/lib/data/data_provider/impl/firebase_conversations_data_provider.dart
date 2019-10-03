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

    // let's get unread message to current user...
    final unreadSnapshot = await _firestore
        .collection('unread_messages')
        .where('to_id', isEqualTo: currentUserID)
        .getDocuments();
    final unreadMessages = unreadSnapshot.documents.map((rawUnreadMessage) {
      rawUnreadMessage.data['id'] = rawUnreadMessage.documentID;
      return rawUnreadMessage.data;
    }).toList();

    // let's get all users...
    final usersSnapshot = await _firestore.collection('users').getDocuments();
    final users = usersSnapshot.documents.map((rawUser) {
      rawUser.data['id'] = rawUser.documentID;
      return rawUser.data;
    }).toList();

    // let's remove current user...
    final filteredUsers =
        users.where((rawUser) => rawUser['id'] != currentUserID).toList();

    // let's map unread messages to all users...
    final usersWithUnreadMessages = filteredUsers.map((user) {
      var unreadCount = 0;
      for (var message in unreadMessages) {
        if (user['id'] == message['from_id']) {
          unreadCount++;
        }
      }

      user['unread_messages_count'] = unreadCount;

      return user;
    }).toList();

    return usersWithUnreadMessages;
  }

  @override
  Future<void> clearUnread({String fromUserID}) async {
    final currentUser = await _firebaseAuth.currentUser();
    final currentUserID = currentUser.uid;

    final snapshots = await _firestore
        .collection('unread_messages')
        .where('to_id', isEqualTo: currentUserID)
        .where('from_id', isEqualTo: fromUserID)
        .getDocuments();

    await Future.forEach(snapshots.documents,
        (DocumentSnapshot docSnapshot) async {
      await docSnapshot.reference.delete();
    });
  }
}
