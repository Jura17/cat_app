import 'package:firebase_test_app/src/features/home/repository/cat_repository.dart';

class CatService {
  final CatRepository _repo;

  CatService(this._repo);

  // Rejects image if it ends in .gif
  Future<String?> getFilteredCatImage() async {
    final url = await _repo.getCatImage();

    if (url != null && url.endsWith('.gif')) {
      return null;
    }
    return url;
  }
}
