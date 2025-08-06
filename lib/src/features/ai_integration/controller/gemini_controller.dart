import 'package:cat_app/src/features/ai_integration/data/gemini_api.dart';
import 'package:flutter/material.dart';

class GeminiController extends ChangeNotifier {
  final GeminiApi geminiApi;
  String? geminiResponse;
  bool isLoading = false;

  GeminiController(this.geminiApi);

  Future<String?> loadGeminiResponse() async {
    isLoading = true;
    notifyListeners();
    await geminiApi.sendRequest();
    geminiResponse = geminiApi.catDescription;
    isLoading = false;
    notifyListeners();
    return geminiResponse;
  }
}
