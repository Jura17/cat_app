import 'package:firebase_test_app/src/core/theme/app_colors.dart';
import 'package:firebase_test_app/src/features/auth/repositories/auth_repository.dart';
import 'package:firebase_test_app/src/features/auth/presentation/screens/password_reset_screen.dart';
import 'package:firebase_test_app/src/features/auth/presentation/widgets/login_form_widget.dart';
import 'package:firebase_test_app/src/features/auth/presentation/widgets/register_form_widget.dart';

import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final AuthRepository authRepository;
  const AuthScreen({
    super.key,
    required this.authRepository,
  });

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
          ],
        ),
      ),
    );
  }

  void toggleAuthScreenUI(bool showRegister) {
    setState(() {
      showRegisterWidget = showRegister;
    });
  }
}
