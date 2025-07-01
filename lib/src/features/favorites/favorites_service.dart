import 'package:firebase_test_app/src/features/auth/data/user_repository.dart';

class FavoritesService {
  final UserRepository userRepo;

  FavoritesService(this.userRepo);

  Future<List<String>?> getFavorites(String uid) async {
    final user = await userRepo.getUser(uid);
    if (user != null) {
      final favorites = await userRepo.getFavorites(user);
      return favorites;
    }
    return null;
  }

  Future<void> markAsFavorite(String url, String uid) async {
    List<String>? favorites = await getFavorites(uid);
    if (favorites != null) {
      favorites.add(url);
      await userRepo.updateFavorites(favorites, uid);
    }
  }

  Future<void> removeFavorite(String url, String uid) async {
    List<String>? favorites = await getFavorites(uid);
    if (favorites != null) {
      favorites.remove(url);
      await userRepo.updateFavorites(favorites, uid);
    }
  }
}
