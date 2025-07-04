import 'package:flutter/material.dart';

class FavoriteModal extends StatelessWidget {
  const FavoriteModal({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 2)),
        child: Image.network(imageUrl),
      ),
    );
  }
}
