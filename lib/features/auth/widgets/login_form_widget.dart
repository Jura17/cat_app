import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/features/auth/data/error_messages.dart';

import 'package:flutter/material.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.showRegisterWidgetFunction,
    required this.authRepository,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function showRegisterWidgetFunction;
  final AuthRepository authRepository;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            TextField(
              decoration: InputDecoration(hintText: "E-Mail"),
              controller: widget.emailController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(hintText: "Passwort"),
              controller: widget.passwordController,
              obscureText: true,
            ),
            SizedBox(height: 20),
            if (errorText != null)
              Text(
                errorText!,
                style: TextStyle(color: Colors.red),
              ),
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: login,
                child: Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
        SizedBox(height: 20),
        Column(
          children: [
            Text("Noch kein Account vorhanden?"),
            TextButton(
              onPressed: () {
                widget.showRegisterWidgetFunction(true);
              },
              child: Text("Hier registrieren"),
            ),
            ElevatedButton(onPressed: () => googleLogin(), child: Text("Google Login"))
          ],
        )
      ],
    );
  }

  void login() async {
    if (widget.emailController.text.isEmpty || widget.passwordController.text.isEmpty) {
      errorText = errorMessages["fields-empty"];
      setState(() {});
      return;
    }

    errorText = await widget.authRepository
        .signInWithEmailPassword(widget.emailController.text, widget.passwordController.text);
    setState(() {});
  }

  void googleLogin() async {
    errorText = await widget.authRepository.signInWithGoogle();
    setState(() {});
  }
}
