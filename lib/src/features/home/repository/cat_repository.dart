import 'package:firebase_test_app/src/features/home/data/cat_api.dart';

class CatRepository {
  final CatApi _api;

  CatRepository(this._api);

  Future<String?> getCatImage() async {
    return _api.fetchCatImageUrl();
  }
}
