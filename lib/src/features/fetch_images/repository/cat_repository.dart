import 'package:cat_app/src/features/fetch_images/data/cat_api.dart';

class CatRepository {
  final CatApi _api;

  CatRepository(this._api);

  Future<String?> getCatImage() async {
    return _api.fetchCatImageUrl();
  }
}
