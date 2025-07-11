import 'package:cat_app/src/features/auth/presentation/screens/password_reset_screen.dart';
import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';
import 'package:cat_app/src/features/auth/data/error_messages.dart';

import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.showRegisterWidgetFunction,
    required this.authRepository,
  });

  final Function showRegisterWidgetFunction;
  final AuthRepository authRepository;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorText;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "E-Mail", border: OutlineInputBorder()),
              controller: emailController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(hintText: "Passwort", border: OutlineInputBorder()),
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (errorText != null)
              Text(
                errorText!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: login,
              child: Text("Anmelden", style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 8),
          ],
        ),
        SizedBox(height: 20),
        Column(
          children: [
            Text(
              "Noch kein Account vorhanden?",
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () {
                widget.showRegisterWidgetFunction(true);
              },
              child: Text("Hier registrieren"),
            ),
            SizedBox(height: 80),
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
        )
      ],
    );
  }

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorText = errorMessages["fields-empty"];
      setState(() {});
      return;
    }

    final error = await widget.authRepository.signInWithEmailPassword(emailController.text, passwordController.text);
    if (!mounted) return;
    setState(() {
      errorText = error;
    });
  }
}
