import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_test_app/src/features/auth/models/database_user.dart';
import 'package:firebase_test_app/src/features/auth/repositories/user_repository.dart';

class FirestoreUserRepository implements UserRepository {
  final FirebaseFirestore _db;

  FirestoreUserRepository(this._db);

  @override
  Future<void> createUser({required String uid, required String username}) async {
    final newUser = DatabaseUser(
      name: username,
      createdAt: DateTime.now(),
      lastLogin: DateTime.now(),
      favoriteImageUrls: <String>[],
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

  @override
  Future<List<String>> getFavorites(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    final data = doc.data();
    if (data == null || !data.containsKey('favoriteImageUrls')) return [];
    return List<String>.from(data['favoriteImageUrls']);
  }

  @override
  Future<void> updateFavorites(List<String> favoriteImageUrls, String uid) async {
    await _db.collection('users').doc(uid).update({
      'favoriteImageUrls': favoriteImageUrls,
    });
  }
}
