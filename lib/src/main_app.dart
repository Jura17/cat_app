import 'package:firebase_auth/firebase_auth.dart';
import 'package:cat_app/src/core/theme/app_theme.dart';

import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';
import 'package:cat_app/src/features/auth/repositories/user_repository.dart';
import 'package:cat_app/src/features/auth/presentation/screens/auth_screen.dart';

import 'package:cat_app/src/features/home/screens/loading_screen.dart';
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                title: Text("~ Katzen ~"),
              ),
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;

            return LoadingScreen(
              user: user,
              authRepository: authRepository,
            );
          }
          return AuthScreen(
            authRepository: authRepository,
          );
        },
      ),
    );
  }
}
