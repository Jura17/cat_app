import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/features/auth/data/error_messages.dart';

import 'package:flutter/material.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    super.key,
    // required this.emailController,
    // required this.passwordController,
    required this.showRegisterWidgetFunction,
    required this.authRepository,
  });
  // final TextEditingController emailController;
  // final TextEditingController passwordController;
  final Function showRegisterWidgetFunction;
  final AuthRepository authRepository;

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  String? errorText;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

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
              controller: emailController,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(hintText: "Passwort"),
              controller: passwordController,
              obscureText: true,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(hintText: "Passwort bestätigen"),
              controller: passwordConfirmController,
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
                onPressed: register,
                child: Text(
                  "Registrieren",
                  style: TextStyle(fontSize: 20),
                )),
          ],
        ),
        SizedBox(height: 20),
        Column(
          children: [
            Text("Bereits einen Account angelegt?"),
            TextButton(
              onPressed: () {
                widget.showRegisterWidgetFunction(false);
              },
              child: Text("Zum Login"),
            ),
            SizedBox(height: 40),
            ElevatedButton(onPressed: () => googleLogin(), child: Text("Über Google anmelden"))
          ],
        )
      ],
    );
  }

  void register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorText = errorMessages["fields-empty"];
      setState(() {});
      return;
    }

    if (passwordController.text != passwordConfirmController.text) {
      errorText = errorMessages["passwords-do-not-match"];
      setState(() {});
      return;
    }

    errorText = await widget.authRepository.registerWithEmailPassword(emailController.text, passwordController.text);
    setState(() {});
  }

  void googleLogin() async {
    errorText = await widget.authRepository.signInWithGoogle();
    setState(() {});
  }
}
