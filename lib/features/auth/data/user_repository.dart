import 'package:firebase_test_app/features/auth/models/database_user.dart';

abstract class UserRepository {
  Future<DatabaseUser?> getUser(String uid);
  Future<List<DatabaseUser>> getAllUsers();
}
