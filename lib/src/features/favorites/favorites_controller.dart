import 'package:cat_app/src/features/favorites/favorites_service.dart';
import 'package:cat_app/src/features/favorites/presentation/widgets/gallery_image.dart';
import 'package:flutter/material.dart';

class FavoritesController extends ChangeNotifier {
  final FavoritesService service;

  bool isLoading = true;
  Set<String> _favorites = {};
  Set<String> selectedImages = {};

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
          content: Text(addedFavorite ? "Added to favorites" : "Already one of your favorites"),
        ),
      );
    }
  }

  Future<void> removeFavorite(String url, String uid) async {
    await service.removeFavorite(url, uid);
    _favorites.remove(url);
    notifyListeners();
  }

  void handleSelection(GalleryImage image) {
    if (selectedImages.contains(image.url)) {
      selectedImages.remove(image.url);
    } else {
      selectedImages.add(image.url);
    }
    notifyListeners();
  }

  void deleteSelectedImages(String uid) async {
    for (String url in selectedImages) {
      await removeFavorite(url, uid);
    }
    selectedImages.clear();
    notifyListeners();
  }

  void clearSelection() {
    selectedImages.clear();
  }

  bool checkIfSelected(String url) {
    return selectedImages.contains(url) ? true : false;
  }
}
