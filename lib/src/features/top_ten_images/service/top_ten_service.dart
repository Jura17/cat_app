import 'package:cat_app/src/features/auth/repositories/user_repository.dart';
import 'package:cat_app/src/features/top_ten_images/data/top_ten_firestore.dart';

class TopTenService {
  final UserRepository userRepo;
  final TopTenFirestore likedImagesFirestore;

  TopTenService({
    required this.userRepo,
    required this.likedImagesFirestore,
  });

  Future<void> addToGlobalFavorites(String url, String uid) async {
    await likedImagesFirestore.createImageDocument(url, uid);
  }

  Future<void> removeLike(String url, String uid) async {
    await likedImagesFirestore.removeLike(url, uid);
  }

  Future<List<String>> getTopTenImages() async {
    final topTenImages = await likedImagesFirestore.loadTopTenImages();
    final imageUrls = topTenImages.map((image) => image.url).toList();
    return imageUrls;
  }
}
