import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test_app/core/theme/app_theme.dart';
import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/features/auth/data/user_repository.dart';
import 'package:firebase_test_app/features/auth/screens/auth_screen.dart';
import 'package:firebase_test_app/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  final AuthRepository authRepository;
  final UserRepository userRepository;

  const MainApp({
    super.key,
    required this.authRepository,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: StreamBuilder<User?>(
          stream: authRepository.onAuthChanged() as Stream<User?>,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data!;
              return HomeScreen(
                user: user,
                authRepository: authRepository,
                userRepository: userRepository,
              );
            }
            return AuthScreen(authRepository: authRepository);
          }),
    );
  }
}
