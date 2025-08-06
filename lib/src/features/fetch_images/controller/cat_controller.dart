import 'package:cat_app/src/features/fetch_images/service/cat_service.dart';
import 'package:flutter/material.dart';

class CatController extends ChangeNotifier {
  final CatService _service;
  String? _catImageUrl;
  bool isLoading = false;

  CatController(this._service);

  String? get catImageUrl => _catImageUrl;

  Future<void> loadCatImage() async {
    isLoading = true;
    notifyListeners();
    _catImageUrl = await _service.getFilteredCatImage();

    isLoading = false;
    notifyListeners();
  }
}
