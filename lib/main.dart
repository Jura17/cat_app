import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test_app/features/auth/data/login_repository.dart';
import 'package:firebase_test_app/features/auth/screens/login_screen.dart';
import 'package:firebase_test_app/firebase_options.dart';
import 'package:firebase_test_app/home_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth auth = FirebaseAuth.instance;
  final loginRepository = LoginRepository(auth);
  runApp(MainApp(loginRepository: loginRepository));
}

class MainApp extends StatelessWidget {
  final LoginRepository loginRepository;

  const MainApp({super.key, required this.loginRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
          stream: loginRepository.onAuthChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final user = snapshot.data!;
              return HomeScreen(user: user, loginRepository: loginRepository);
            }
            return LoginScreen(loginRepository: loginRepository);
          }),
    );
  }
}
