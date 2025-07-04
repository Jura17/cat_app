import 'package:firebase_test_app/src/features/favorites/favorites_controller.dart';
import 'package:firebase_test_app/src/features/favorites/presentation/widgets/favorite_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GalleryImage extends StatefulWidget {
  const GalleryImage({
    super.key,
    required this.deleteMode,
    required this.url,
  });

  final bool deleteMode;
  final String url;

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  @override
  Widget build(BuildContext context) {
    final favoritesController = context.watch<FavoritesController>();
    return GestureDetector(
      onTap: () async {
        if (widget.deleteMode) {
          setState(() {
            context.read<FavoritesController>().handleSelection(widget);
          });
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return FavoriteModal(
                imageUrl: widget.url,
              );
            },
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 2,
          ),
        ),
        key: Key(widget.url),
        width: 75,
        height: 75,
        child: Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                widget.url,
                fit: BoxFit.cover,
              ),
            ),
            if (widget.deleteMode)
              Positioned(
                top: 10,
                right: 10,
                child: Icon(
                  Icons.delete,
                  color: favoritesController.checkIfSelected(widget.url) ? Colors.red : Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
