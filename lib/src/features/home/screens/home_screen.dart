import 'package:cat_app/src/features/auth/controller/user_controller.dart';
import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';

import 'package:cat_app/src/features/favorites/favorites_controller.dart';

import 'package:cat_app/src/features/home/controller/cat_controller.dart';
import 'package:cat_app/src/features/home/widgets/error_container.dart';
import 'package:cat_app/src/features/home/widgets/image_container.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user,
    required this.authRepository,
  });
  final User user;
  final AuthRepository authRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String? apiKey = dotenv.env['API_KEY'];
  late GenerativeModel _model;
  String? catDescription;
  bool descriptionLoading = false;

  @override
  void initState() {
    if (apiKey != null) {
      _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey!);
    }
    super.initState();
  }

  Future<void> generateDescription(CatController catController, GenerativeModel model) async {
    final String? imageUrl = catController.catImageUrl;
    if (imageUrl != null) {
      final fetchedImage = await http.get(Uri.parse(imageUrl));
      final imageBytes = fetchedImage.bodyBytes;
      GenerateContentResponse? response;
      String errorText = "";

      final promptContent = [
        Content.multi([
          TextPart(
              "Describe the breed of the cat in this image and what it is doing in 1-2 short sentences in German."),
          DataPart('image/jpeg', imageBytes),
        ]),
      ];

      try {
        response = await model.generateContent(promptContent);
        catDescription = response.text;
      } catch (e) {
        errorText = e.toString();
        response = null;
        catDescription = errorText;
      }
      descriptionLoading = false;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final catController = context.read<CatController>();
    final favoritesController = context.read<FavoritesController>();
    final userController = context.read<UserController>();
    final userName = userController.user?.name;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await widget.authRepository.logOut();
              userController.resetUser();
            },
            child: Text("Logout"),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                Text(
                  "Hallo ${userName ?? "Nutzer"}",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                SizedBox(
                  height: 400,
                  child: Consumer<CatController>(
                    builder: (context, catController, _) {
                      if (catController.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (catController.catImageUrl == null) {
                        return ErrorContainer();
                      }
                      return ImageContainer(catController: catController);
                    },
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (catController.catImageUrl != null) {
                          await favoritesController.markAsFavorite(
                              catController.catImageUrl!, widget.user.uid, context);
                        }
                      },
                      child: Text(
                        "Mag ich ❤️",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await catController.loadCatImage();
                        catDescription = null;
                        setState(() {});
                      },
                      child: Text(
                        "Weiter",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: descriptionLoading && catDescription == null
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        )
                      : Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              child: catDescription != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        catDescription!,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    )
                                  : ElevatedButton(
                                      onPressed: () async {
                                        descriptionLoading = true;
                                        setState(() {});
                                        await generateDescription(catController, _model);
                                      },
                                      child: Text(
                                        "Was sehe ich da? 🐱",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
