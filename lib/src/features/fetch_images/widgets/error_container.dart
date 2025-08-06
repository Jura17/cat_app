import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "There was an error loading the image",
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
