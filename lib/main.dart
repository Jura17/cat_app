import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/features/auth/data/firebase_auth_repository.dart';
import 'package:firebase_test_app/features/auth/screens/auth_screen.dart';
import 'package:firebase_test_app/firebase_options.dart';
import 'package:firebase_test_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  final AuthRepository authRepository = FirebaseAuthRepository(auth);
  runApp(MainApp(authRepository: authRepository));
}

class MainApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MainApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
          stream: authRepository.onAuthChanged() as Stream<User?>,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data!;
              return HomeScreen(user: user, loginRepository: authRepository);
            }
            return AuthScreen(loginRepository: authRepository);
          }),
    );
  }
}
