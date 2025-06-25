import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cat_app/features/auth/data/user_repository.dart';
import 'package:cat_app/features/auth/models/database_user.dart';

class FirestoreUserRepository implements UserRepository {
  final FirebaseFirestore _db;

  FirestoreUserRepository(this._db);

  @override
  Future<void> createUser({required String uid, required String username}) async {
    final newUser = DatabaseUser(
      name: username,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
    );

    await _db.collection('users').doc(uid).set(newUser.toMap());
  }

  @override
  Future<void> updateLastLogin({required String uid}) async {
    await _db.collection('users').doc(uid).update({
      'lastLogin': FieldValue.serverTimestamp(),
    });
  }

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
