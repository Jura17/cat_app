import 'package:cat_app/src/features/home/repository/cat_repository.dart';
import 'package:flutter/material.dart';

class CatService {
  final CatRepository _repo;

  CatService(this._repo);

  // Rejects image if it ends in .gif
  Future<String?> getFilteredCatImage() async {
    var url = await _repo.getCatImage();

    while (url != null && url.endsWith('.gif')) {
      debugPrint("That was a gif");
      url = await _repo.getCatImage();
    }
    return url;
  }
}
