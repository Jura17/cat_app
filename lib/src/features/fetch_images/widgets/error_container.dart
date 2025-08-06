import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "Es konnte kein Bild geladen werden",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
