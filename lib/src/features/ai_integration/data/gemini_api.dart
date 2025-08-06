import 'package:cat_app/src/features/fetch_images/controller/cat_controller.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

class GeminiApi {
  final String? apiKey = dotenv.env['API_KEY'];
  late GenerativeModel _model;
  GenerateContentResponse? response;
  final CatController _catController;
  String? catDescription = "";

  GeminiApi(this._catController);

  Future<void> sendRequest() async {
    final String? imageUrl = _catController.catImageUrl;

    if (apiKey == null) return;
    if (imageUrl == null) return;

    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey!);

    final fetchedImage = await http.get(Uri.parse(imageUrl));
    final imageBytes = fetchedImage.bodyBytes;
    GenerateContentResponse? response;
    String errorText = "";

    final promptContent = [
      Content.multi([
        TextPart("Describe the breed of the cat in this image and what it is doing in 1-2 short sentences in English."),
        DataPart('image/jpeg', imageBytes),
      ]),
    ];

    try {
      response = await _model.generateContent(promptContent);
      catDescription = response.text;
    } catch (e) {
      if (e.toString().contains('503')) {
        errorText = "Servers are currently busy. Please try again later...";
      } else {
        errorText = e.toString();
      }
      response = null;
      catDescription = errorText;
    }
  }
}
