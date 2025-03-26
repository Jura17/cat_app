import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test_app/features/auth/data/error_messages.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  AuthRepository(this._auth);

  Stream<User?> get onAuthChanged => _auth.authStateChanges();

  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String? errorMessage = errorMessages[e.code];
      return errorMessage;
    }
    return null;
  }

  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String? errorMessage = errorMessages[e.code];
      return errorMessage;
    }
    return null;
  }

  Future<void> logout() async {
    await _auth.signOut();
  }
}
