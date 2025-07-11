import 'package:cat_app/src/features/auth/repositories/user_repository.dart';

class FavoritesService {
  final UserRepository userRepo;

  FavoritesService(this.userRepo);

  Future<List<String>?> getFavorites(String uid) async {
    final user = await userRepo.getUser(uid);
    if (user != null) {
      final favorites = await userRepo.getFavorites(uid);

      return favorites;
    }
    return null;
  }

  Future<bool> markAsFavorite(String url, String uid) async {
    List<String>? favorites = await getFavorites(uid);

    if (favorites == null) return false;
    Set<String> favoritesSet = favorites.toSet();
    if (favoritesSet.contains(url)) {
      return false;
    } else {
      favoritesSet.add(url);
      favorites = favoritesSet.toList();

      await userRepo.updateFavorites(favorites, uid);
      return true;
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
