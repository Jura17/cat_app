import 'package:firebase_test_app/features/auth/data/login_repository.dart';
import 'package:firebase_test_app/features/auth/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final LoginRepository loginRepository;
  const RegisterScreen({super.key, required this.loginRepository});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Register"),
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
                ),
                SizedBox(height: 20),
                if (errorText != null)
                  Text(
                    errorText!,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: register,
                  child: Text(
                    "Registrieren",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Column(
              children: [
                Text("Bereits einen Account angelegt?"),
                TextButton(
                  onPressed: () => Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginScreen(loginRepository: widget.loginRepository),
                  )),
                  child: Text("Zum Login"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      errorText = "Bitte E-Mail-Adresse und Passwort angeben";
      setState(() {});
      return;
    }

    errorText = await widget.loginRepository.register(emailController.text, passwordController.text);
    setState(() {});
  }
}
