import 'package:cat_app/src/features/top_ten_images/service/top_ten_service.dart';
import 'package:flutter/material.dart';

class TopTenController extends ChangeNotifier {
  final TopTenService _service;

  bool isLoading = true;
  List<String>? _topTenImages;

  TopTenController(this._service);

  List<String>? get topTenImages => _topTenImages;

  Future<void> addToGlobalFavorites(String url, String uid) async {
    await _service.addToGlobalFavorites(url, uid);
  }

  Future<void> removeLike(Set<String> urls, String uid) async {
    for (String url in urls) {
      await _service.removeLike(url, uid);
    }
  }

  Future<void> loadTopTenImages() async {
    isLoading = true;
    notifyListeners();
    _topTenImages = await _service.getTopTenImages();
    isLoading = false;
    notifyListeners();
  }
}
