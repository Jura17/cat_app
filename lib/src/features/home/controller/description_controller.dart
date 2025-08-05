import 'package:cat_app/src/features/home/controller/cat_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;

class DescriptionController extends ChangeNotifier {
  final String? apiKey = dotenv.env['API_KEY'];
  late GenerativeModel _model;
  final CatController catController;
  var catDescription = "";

  DescriptionController(this.catController) {
    if (apiKey != null) {
      _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey!);
    }
  }

  Future<void> generateDescription() async {
    final String? imageUrl = catController.catImageUrl;
    if (imageUrl != null) {
      final fetchedImage = await http.get(Uri.parse(imageUrl));
      final imageBytes = fetchedImage.bodyBytes;
      GenerateContentResponse? response;
      String errorText = "";

      final promptContent = [
        Content.multi([
          TextPart("Describe the breed of the cat in this image and what it is doing in 1–2 short sentences."),
          DataPart('image/jpeg', imageBytes),
        ]),
      ];

      try {
        response = await _model.generateContent(promptContent);
      } catch (e) {
        errorText = e.toString();
        response = null;
        print(errorText);
      }

      catDescription = response?.text ?? "";
    }
  }
}
