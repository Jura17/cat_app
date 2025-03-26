import 'package:firebase_test_app/features/auth/data/login_repository.dart';
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
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            decoration: InputDecoration(hintText: "E-Mail"),
            controller: emailController,
          ),
          TextField(
            decoration: InputDecoration(hintText: "Passwort"),
            controller: passwordController,
          )
        ],
      ),
    );
  }

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bitte E-Mail und Passwort angeben.")));
      return;
    }

    errorText = await widget.loginRepository.login(emailController.text, passwordController.text);
    setState(() {});
  }

  void register() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Bitte E-Mail und Passwort angeben.")));
      return;
    }

    errorText = await widget.loginRepository.register(emailController.text, passwordController.text);
    setState(() {});
  }
}
