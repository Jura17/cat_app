import 'package:firebase_test_app/src/features/favorites/favorites_controller.dart';
import 'package:firebase_test_app/src/features/favorites/presentation/widgets/favorite_modal.dart';
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

  Set<String> selectedImages = {};

  @override
  Widget build(BuildContext context) {
    final favoritesController = context.watch<FavoritesController>();
    Set<String> favorites = favoritesController.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Deine Favoriten"),
        actions: [
          TextButton.icon(
            icon: Icon(
              Icons.delete,
              size: 25,
            ),
            onPressed: () {
              deleteMode = !deleteMode;
              setState(() {});
              debugPrint(deleteMode.toString());
            },
            label: Text(deleteMode ? "Abbrechen" : "Löschen"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: favorites.isEmpty
              ? Text(
                  "Hier gibt's noch nichts zu sehen",
                  style: TextStyle(fontSize: 18),
                )
              : GridView.count(
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
      ),
    );
  }
}

class GalleryImage extends StatefulWidget {
  const GalleryImage({super.key, required this.deleteMode, required this.url});

  final bool deleteMode;
  final String url;

  @override
  State<GalleryImage> createState() => _GalleryImageState();
}

class _GalleryImageState extends State<GalleryImage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (widget.deleteMode) {
          debugPrint("delete");
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
                child: Icon(Icons.delete),
              ),
          ],
        ),
      ),
    );
  }
}
