import 'package:firebase_test_app/src/features/home/service/cat_service.dart';
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
