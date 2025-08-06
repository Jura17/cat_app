import 'package:cat_app/src/features/ai_integration/controller/gemini_controller.dart';
import 'package:cat_app/src/features/auth/controller/user_controller.dart';
import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';

import 'package:cat_app/src/features/favorites/favorites_controller.dart';

import 'package:cat_app/src/features/fetch_images/controller/cat_controller.dart';
import 'package:cat_app/src/features/fetch_images/widgets/cat_description_container.dart';
import 'package:cat_app/src/features/fetch_images/widgets/cat_image_container.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  @override
  Widget build(BuildContext context) {
    final catController = context.read<CatController>();
    final userController = context.read<UserController>();
    final geminiController = context.watch<GeminiController>();
    final favoritesController = context.read<FavoritesController>();
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
                  "Hi there ${userName ?? "user"}",
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CatImageContainer(),
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
                        "Like it ❤️",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await catController.loadCatImage();
                        setState(() {
                          geminiController.geminiResponse = null;
                        });
                      },
                      child: Text(
                        "Next one",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                CatDescriptionContainer(geminiController: geminiController),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
