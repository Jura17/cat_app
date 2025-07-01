import 'package:firebase_test_app/src/features/favorites/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesGalleryScreen extends StatefulWidget {
  const FavoritesGalleryScreen({super.key});

  @override
  State<FavoritesGalleryScreen> createState() => _FavoritesGalleryScreenState();
}

class _FavoritesGalleryScreenState extends State<FavoritesGalleryScreen> {
  @override
  Widget build(BuildContext context) {
    final favoritesController = context.watch<FavoritesController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Your Favorites"),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          children: [],
        ),
      ),
    );
  }
}
