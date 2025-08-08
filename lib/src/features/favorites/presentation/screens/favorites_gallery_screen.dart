import 'package:cat_app/src/features/favorites/favorites_controller.dart';

import 'package:cat_app/src/features/favorites/presentation/widgets/gallery_image.dart';
import 'package:cat_app/src/features/top_ten_images/controller/top_ten_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesGalleryScreen extends StatefulWidget {
  const FavoritesGalleryScreen({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  State<FavoritesGalleryScreen> createState() => _FavoritesGalleryScreenState();
}

class _FavoritesGalleryScreenState extends State<FavoritesGalleryScreen> {
  bool deleteMode = false;

  @override
  Widget build(BuildContext context) {
    final favoritesController = context.watch<FavoritesController>();
    final topTenController = context.read<TopTenController>();
    Set<String> favorites = favoritesController.favorites;

    // deselect all images when leaving the screen
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        favoritesController.clearSelection();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Your Favorites"),
          actions: [
            TextButton.icon(
              icon: Icon(
                Icons.delete,
                size: 25,
              ),
              onPressed: () {
                deleteMode = !deleteMode;
                if (!deleteMode) favoritesController.clearSelection();
                setState(() {});
              },
              label: Text(deleteMode ? "Cancel" : "Delete"),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                favorites.isEmpty
                    ? Text(
                        "Nothing to see here just yet.",
                        style: TextStyle(fontSize: 18),
                      )
                    : Expanded(
                        child: GridView.count(
                          crossAxisCount: 3,
                          children: [
                            ...favorites.map(
                              (url) => GalleryImage(
                                deleteMode: deleteMode,
                                url: url,
                              ),
                            )
                          ],
                        ),
                      ),
                // show button to delete selected images
                if (deleteMode && favoritesController.selectedImages.isNotEmpty)
                  ElevatedButton(
                    onPressed: () async {
                      await topTenController.removeLike(favoritesController.selectedImages, widget.uid);
                      favoritesController.deleteSelectedImages(widget.uid);
                    },
                    child: Text("Delete selected"),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
