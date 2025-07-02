abstract class AuthRepository {
  Future<String?> signInWithEmailPassword(String email, String password);
  Future<String?> registerWithEmailPassword(String email, String password, String username);
  Future<void> logOut();

  Stream<dynamic> onAuthChanged();
  Future<String?> resetPassword(String email);
}
