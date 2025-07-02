import 'package:firebase_test_app/src/features/favorites/favorites_service.dart';
import 'package:flutter/material.dart';

class FavoritesController extends ChangeNotifier {
  final FavoritesService service;

  bool isLoading = true;
  Set<String> _favorites = {};

  FavoritesController(this.service);

  Set<String> get favorites => _favorites;

  Future<void> loadFavorites(String uid) async {
    isLoading = true;
    notifyListeners();
    final favorites = await service.getFavorites(uid);
    if (favorites != null) _favorites = favorites.toSet();
    isLoading = false;
    notifyListeners();
  }

  Future<bool> markAsFavorite(String url, String uid) async {
    final bool addedFavorite = await service.markAsFavorite(url, uid);
    if (addedFavorite) {
      _favorites.add(url);
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> removeFavorite(String url, String uid) async {
    await service.removeFavorite(url, uid);
    _favorites.remove(url);
    notifyListeners();
  }
}
