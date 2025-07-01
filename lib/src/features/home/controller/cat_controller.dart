import 'package:firebase_test_app/src/features/home/service/cat_service.dart';
import 'package:flutter/material.dart';

class CatController extends ChangeNotifier {
  final CatService _service;
  String? _catImageUrl;
  bool isLoading = true;

  CatController(this._service);

  String? get catImageUrl => _catImageUrl;

  Future<void> initialize() async {
    await loadCatImage();
  }

  Future<void> loadCatImage() async {
    isLoading = true;
    _catImageUrl = await _service.getFilteredCatImage();

    isLoading = false;
    notifyListeners();
  }
}
