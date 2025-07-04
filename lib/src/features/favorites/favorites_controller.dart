import 'package:firebase_test_app/src/features/favorites/favorites_service.dart';
import 'package:flutter/material.dart';

class FavoritesController extends ChangeNotifier {
  final FavoritesService service;

  bool isLoading = true;
  Set<String> _favorites = {};

  FavoritesController(this.service);

  Set<String> get favorites => _favorites;

  Future<void> loadFavorites(String uid) async {
    final favorites = await service.getFavorites(uid);
    if (favorites != null) _favorites = favorites.toSet();
  }

  Future<void> markAsFavorite(String url, String uid, BuildContext context) async {
    final bool addedFavorite = await service.markAsFavorite(url, uid);
    if (addedFavorite) {
      _favorites.add(url);
      notifyListeners();
    }
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(addedFavorite ? "Zu Favoriten hinzugefügt" : "Bereits als Favorit gespeichert"),
        ),
      );
    }
  }

  Future<void> removeFavorite(String url, String uid) async {
    await service.removeFavorite(url, uid);
    _favorites.remove(url);
    notifyListeners();
  }
}
