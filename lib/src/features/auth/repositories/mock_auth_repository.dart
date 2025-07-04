import 'dart:async';

import 'package:collection/collection.dart';
import 'package:firebase_test_app/src/features/auth/repositories/auth_repository.dart';
import 'package:firebase_test_app/src/features/auth/data/error_messages.dart';
import 'package:firebase_test_app/src/features/auth/models/auth_data.dart';
import 'package:uuid/uuid.dart';

class MockAuthRepository implements AuthRepository {
  final List<AuthData> users = [];

  StreamController<AuthData?> streamController = StreamController<AuthData?>();

  @override
  Future<void> logOut() async {
    streamController.add(null);
  }

  @override
  Stream onAuthChanged() {
    return streamController.stream;
  }

  @override
  Future<String?> registerWithEmailPassword(String email, String password, String username) async {
    // überprüfe ob User bereits vorhanden
    final foundUser = users.firstWhereOrNull((user) => user.email == email);

    if (foundUser != null) {
      return errorMessages["email-already-in-use"];
    } else {
      final user = AuthData(email: email, password: password, uid: Uuid().v4());

      // zur "Datenbank" hinzufügen
      users.add(user);

      // "einloggen"
      streamController.add(user);
    }
    return null;
  }

  @override
  Future<String?> signInWithEmailPassword(String email, String password) async {
    // überprüfe ob User bereits vorhanden
    final foundUser = users.firstWhereOrNull((user) => user.email == email);

    if (foundUser == null) {
      return errorMessages["user-not-found"];
    } else {
      if (foundUser.password == password) {
        streamController.add(foundUser);
        return null;
      } else {
        return errorMessages["wrong-password"];
      }
    }
  }

  @override
  Future<String?> resetPassword(String email) async {
    return null;
  }
}
