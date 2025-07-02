import 'package:firebase_test_app/src/features/auth/models/database_user.dart';
import 'package:firebase_test_app/src/features/auth/repositories/user_repository.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  UserController(this.userRepository);

  final UserRepository userRepository;

  bool _isLoading = false;
  DatabaseUser? _user;

  DatabaseUser? get user => _user;
  bool get isLoading => _isLoading;

  Future<void> loadUser(String uid) async {
    _isLoading = true;
    notifyListeners();

    try {
      _user = await userRepository.getUser(uid);
    } catch (e) {
      debugPrint("Failed to load user: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetUser() {
    _user = null;
    notifyListeners();
  }
}
