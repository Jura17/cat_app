import 'package:firebase_auth/firebase_auth.dart';
import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';
import 'package:cat_app/src/features/auth/data/error_messages.dart';

import 'package:cat_app/src/features/auth/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthRepository implements AuthRepository {
  final FirebaseAuth auth;
  final UserRepository userRepository;

  FirebaseAuthRepository({
    required this.auth,
    required this.userRepository,
  });

  @override
  Stream<User?> onAuthChanged() => auth.authStateChanges();

  @override
  Future<String?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential cred = await auth.signInWithEmailAndPassword(email: email, password: password);
      userRepository.updateLastLogin(uid: cred.user!.uid);
    } on FirebaseAuthException catch (e) {
      String? errorMessage = errorMessages[e.code];
      return errorMessage;
    }
    return null;
  }

  @override
  Future<String?> registerWithEmailPassword(String email, String password, String username) async {
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(email: email, password: password);
      userRepository.createUser(uid: cred.user!.uid, username: username);
    } on FirebaseAuthException catch (e) {
      String? errorMessage = errorMessages[e.code];
      errorMessage ??= "An unknown error has occurred.";
      return errorMessage;
    }
    return null;
  }

  @override
  Future<void> logOut() async {
    await GoogleSignIn().signOut();
    await auth.signOut();
  }

  @override
  Future<String?> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }

      return "${errorMessages[e.code]}";
    }
  }
}
