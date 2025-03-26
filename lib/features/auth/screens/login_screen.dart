import 'package:firebase_test_app/features/auth/data/login_repository.dart';
import 'package:firebase_test_app/features/auth/screens/register_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final LoginRepository loginRepository;
  const LoginScreen({super.key, required this.loginRepository});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => RegisterScreen(loginRepository: widget.loginRepository),
                  )),
                  child: Text("Hier registrieren"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorText = "Bitte E-Mail-Adresse und Passwort angeben";
      setState(() {});
      return;
    }

    errorText = await widget.loginRepository.login(emailController.text, passwordController.text);
    setState(() {});
  }
}
