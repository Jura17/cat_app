import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final FirebaseAuth _auth;
  LoginRepository(this._auth);

  // Um auf einen Stream zuhören
  Stream<User?> get onAuthChanged => _auth.authStateChanges();

  // try-catch um User zu authentifizieren
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "invalid-credentials") {
        return "Falsche Anmeldedaten";
      }
    }
    return null;
  }

  Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "E-Mail-Adresse ist bereits vergeben";
      }
    }
    return null;
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
