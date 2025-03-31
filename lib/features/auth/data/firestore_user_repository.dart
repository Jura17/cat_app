import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test_app/features/auth/data/user_repository.dart';
import 'package:firebase_test_app/features/auth/models/database_user.dart';

class FirestoreUserRepository implements UserRepository {
  FirestoreUserRepository(this._db);

  final FirebaseFirestore _db;

  @override
  Future<List<DatabaseUser>> getAllUsers() async {
    final userDocs = await _db.collection("users").get();

    List<DatabaseUser> users = [];

    for (var doc in userDocs.docs) {
      users.add(DatabaseUser.fromMap(doc.data()));
    }
    return users;
  }

  @override
  Future<DatabaseUser?> getUser(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();

    if (doc.exists) {
      final data = doc.data();
      if (data != null) {
        return DatabaseUser.fromMap(data);
      }
    }
    return null;
  }
}
