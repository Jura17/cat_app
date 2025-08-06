import 'package:cat_app/src/features/ai_integration/controller/gemini_controller.dart';
import 'package:flutter/material.dart';

class CatDescriptionContainer extends StatelessWidget {
  const CatDescriptionContainer({
    super.key,
    required this.geminiController,
  });

  final GeminiController geminiController;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: geminiController.isLoading && geminiController.geminiResponse == null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            )
          : Expanded(
              child: SingleChildScrollView(
                child: Container(
                  child: geminiController.geminiResponse != null
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            geminiController.geminiResponse!,
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            await geminiController.loadGeminiResponse();
                          },
                          child: Text(
                            "What am I looking at? 🐱",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                ),
              ),
            ),
    );
  }
}
