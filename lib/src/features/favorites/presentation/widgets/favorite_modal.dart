import 'package:flutter/material.dart';

class FavoriteModal extends StatelessWidget {
  const FavoriteModal({
    super.key,
    required this.imageUrl,
  });

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.network(imageUrl),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Some text that describes the image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
