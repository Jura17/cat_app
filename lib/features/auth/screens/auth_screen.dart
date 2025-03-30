import 'package:firebase_test_app/core/theme/app_colors.dart';
import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/features/auth/screens/password_reset_screen.dart';
import 'package:firebase_test_app/features/auth/widgets/login_form_widget.dart';
import 'package:firebase_test_app/features/auth/widgets/register_form_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';

class AuthScreen extends StatefulWidget {
  final AuthRepository authRepository;
  const AuthScreen({super.key, required this.authRepository});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool showRegisterWidget = false;

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "~ Katzen ~",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            SizedBox(height: 30),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return SlideTransition(
                  position: Tween<Offset>(begin: Offset(1.0, 0.0), end: Offset.zero).animate(animation),
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              child: showRegisterWidget
                  ? RegisterFormWidget(
                      showRegisterWidgetFunction: toggleAuthScreenUI,
                      authRepository: widget.authRepository,
                    )
                  : LoginFormWidget(
                      showRegisterWidgetFunction: toggleAuthScreenUI,
                      authRepository: widget.authRepository,
                    ),
            ),
            SizedBox(height: 30),
            SignInButton(
              Buttons.Google,
              onPressed: () => googleLogin(),
              text: "Über Google anmelden",
            ),
            SizedBox(height: 100),
            TextButton(
              style: Theme.of(context).textButtonTheme.style,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => PasswordResetScreen(authRepository: widget.authRepository),
                  ),
                );
              },
              child: Text("Passwort zurücksetzen"),
            ),
          ],
        ),
      ),
    );
  }

  void toggleAuthScreenUI(bool showRegister) {
    showRegisterWidget = showRegister;
    setState(() {});
  }

  void googleLogin() async {
    errorText = await widget.authRepository.signInWithGoogle();
    setState(() {});
  }
}
