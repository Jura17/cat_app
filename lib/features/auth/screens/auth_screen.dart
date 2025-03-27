import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/features/auth/widgets/login_form_widget.dart';
import 'package:firebase_test_app/features/auth/widgets/register_form_widget.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final AuthRepository loginRepository;
  const AuthScreen({super.key, required this.loginRepository});

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
      appBar: AppBar(
        title: Text(showRegisterWidget ? "Firebase Register" : "Firebase Login"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: showRegisterWidget
            ? RegisterFormWidget(
                // emailController: emailController,
                // passwordController: passwordController,
                showRegisterWidgetFunction: updateAuthScreenUI,
                authRepository: widget.loginRepository,
              )
            : LoginFormWidget(
                // emailController: emailController,
                // passwordController: passwordController,
                showRegisterWidgetFunction: updateAuthScreenUI,
                authRepository: widget.loginRepository,
              ),
      ),
    );
  }

  void updateAuthScreenUI(bool showRegister) {
    showRegisterWidget = showRegister;
    setState(() {});
  }
}
