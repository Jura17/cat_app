import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({
    super.key,
    required this.authRepository,
  });

  final AuthRepository authRepository;

  @override
  State<PasswordResetScreen> createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _errorText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Passwort zurücksetzen")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: "E-Mail", border: OutlineInputBorder()),
              controller: _emailController,
            ),
            SizedBox(height: 20),
            _errorText == null
                ? Text(
                    "Eine Bestätigungs-E-Mail wurde verschickt.",
                    style: TextStyle(color: Colors.green),
                  )
                : Text(
                    _errorText!,
                    style: TextStyle(color: Colors.red),
                  ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: passwordReset,
              child: Text("Passwort zurücksetzen"),
            )
          ],
        ),
      ),
    );
  }

  void passwordReset() async {
    _errorText = await widget.authRepository.resetPassword(_emailController.text);
    setState(() {});
  }
}
