import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_test_app/src/core/theme/app_theme.dart';
import 'package:firebase_test_app/src/features/auth/controller/user_controller.dart';
import 'package:firebase_test_app/src/features/auth/repositories/auth_repository.dart';
import 'package:firebase_test_app/src/features/auth/repositories/user_repository.dart';
import 'package:firebase_test_app/src/features/auth/presentation/screens/auth_screen.dart';
import 'package:firebase_test_app/src/features/favorites/favorites_controller.dart';
import 'package:firebase_test_app/src/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

            // load user data once logged in;
            // prevent 'markNeedsBuild during build' exception
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              final userController = context.read<UserController>();
              final favoritesController = context.read<FavoritesController>();

              // Avoid reloading user if already loaded
              if (userController.user == null) {
                userController.loadUser(user.uid);
              }

              favoritesController.loadFavorites(user.uid);
            });
            return HomeScreen(
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
