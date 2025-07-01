import 'package:firebase_test_app/src/features/favorites/favorites_service.dart';
import 'package:flutter/material.dart';

class FavoritesController extends ChangeNotifier {
  final FavoritesService service;

  bool isLoading = true;
  List<String> _favorites = [];

  FavoritesController(this.service);

  List<String> get favorites => _favorites;

  Future<void> loadFavorites(String uid) async {
    final favorites = await service.getFavorites(uid);
    if (favorites != null) _favorites = favorites;
    notifyListeners();
  }

  Future<void> markAsFavorite(String url, String uid) async {
    service.markAsFavorite(url, uid);
    loadFavorites(uid);
  }

  Future<void> removeFavorite(String url, String uid) async {
    service.removeFavorite(url, uid);
    loadFavorites(uid);
  }
}
