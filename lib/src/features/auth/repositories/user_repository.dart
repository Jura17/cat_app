import 'package:firebase_test_app/src/features/auth/models/database_user.dart';

abstract class UserRepository {
  Future<void> createUser({required String uid, required String username});
  Future<void> updateLastLogin({required String uid});
  Future<DatabaseUser?> getUser(String uid);
  Future<List<DatabaseUser>> getAllUsers();
  Future<List<String>?> getFavorites(String uid);
  Future<void> updateFavorites(List<String> favorites, String uid);
}
