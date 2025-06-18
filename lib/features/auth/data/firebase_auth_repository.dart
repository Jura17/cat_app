import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/features/auth/data/error_messages.dart';

import 'package:firebase_test_app/features/auth/data/user_repository.dart';
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
      errorMessage ??= "Ein unbekannter Fehler ist aufgetreten.";
      return errorMessage;
    }
    return null;
  }

  @override
  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await auth.signInWithCredential(credential);
    } on Exception catch (e) {
      if (kDebugMode) {
        print('exception->$e');
      }
      return "Google-Fehler: $e";
    } on AssertionError catch (_) {
      return null;
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
