import 'package:cat_app/features/auth/models/database_user.dart';

abstract class UserRepository {
  Future<void> createUser({required String uid, required String username});
  Future<void> updateLastLogin({required String uid});
  Future<DatabaseUser?> getUser(String uid);
  Future<List<DatabaseUser>> getAllUsers();
}
