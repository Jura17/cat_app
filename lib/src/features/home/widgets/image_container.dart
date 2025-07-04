import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_test_app/src/features/home/controller/cat_controller.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
    required this.catController,
  });

  final CatController catController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: catController.catImageUrl!,
        errorWidget: (context, url, error) => Icon(Icons.broken_image),
      ),
    );
  }
}
