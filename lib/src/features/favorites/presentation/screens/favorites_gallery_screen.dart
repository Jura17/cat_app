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
  @override
  Widget build(BuildContext context) {
    final favoritesController = context.watch<FavoritesController>();
    Set<String> favorites = favoritesController.favorites;

    return Scaffold(
      appBar: AppBar(
        title: Text("Deine Favoriten"),
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
                      (url) => GestureDetector(
                        onTap: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return FavoriteModal(
                                imageUrl: url,
                              );
                            },
                          );
                          // await favoritesController.removeFavorite(url, widget.uid);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          key: Key(url),
                          width: 75,
                          height: 75,
                          child: Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
