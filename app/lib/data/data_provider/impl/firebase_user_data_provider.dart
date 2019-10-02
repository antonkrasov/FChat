import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fchat/data/data_provider/user_data_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserDataProvider extends UserDataProvider {
  static const kUsersCollection = 'users';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  Future<Map> getUser() async {
    var firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser == null) {
      return null;
    }

    final userDoc = await _firestore
        .collection(kUsersCollection)
        .document(firebaseUser.uid)
        .get();

    return {
      'id': firebaseUser.uid,
      'name': userDoc.data['name'],
    };
  }

  @override
  Future<Map> login({String name}) async {
    final authResult = await _firebaseAuth.signInAnonymously();

    final rawUser = {
      'id': authResult.user.uid,
      'name': name,
    };

    // let's create a record in database.
    await _firestore
        .collection(kUsersCollection)
        .document(authResult.user.uid)
        .setData(rawUser, merge: true);

    return rawUser;
  }
}
