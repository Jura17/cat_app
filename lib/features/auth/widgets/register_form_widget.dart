import 'package:cat_app/features/auth/data/auth_repository.dart';
import 'package:cat_app/features/auth/data/error_messages.dart';

import 'package:flutter/material.dart';

class RegisterFormWidget extends StatefulWidget {
  const RegisterFormWidget({
    super.key,
    required this.showRegisterWidgetFunction,
    required this.authRepository,
  });

  final Function showRegisterWidgetFunction;
  final AuthRepository authRepository;

  @override
  State<RegisterFormWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController = TextEditingController();
  String? errorText;

  @override
  void dispose() {
    usernameController.dispose();
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
              decoration: InputDecoration(hintText: "Username", border: OutlineInputBorder()),
              controller: usernameController,
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(hintText: "Passwort bestätigen", border: OutlineInputBorder()),
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
              child: Text("Registrieren", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
        SizedBox(height: 20),
        Column(
          children: [
            Text(
              "Bereits einen Account angelegt?",
              style: TextStyle(fontSize: 18),
            ),
            TextButton(
              onPressed: () {
                widget.showRegisterWidgetFunction(false);
              },
              child: Text("Zum Login"),
            ),
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

    final String email = emailController.text;
    final String password = passwordController.text;
    final String username = usernameController.text;

    final error = await widget.authRepository.registerWithEmailPassword(email, password, username);
    if (!mounted) return;
    setState(() {
      errorText = error;
    });
  }
}
