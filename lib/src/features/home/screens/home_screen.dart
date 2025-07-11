import 'package:cat_app/src/features/auth/controller/user_controller.dart';
import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';

import 'package:cat_app/src/features/favorites/favorites_controller.dart';
import 'package:cat_app/src/features/favorites/presentation/screens/favorites_gallery_screen.dart';
import 'package:cat_app/src/features/home/controller/cat_controller.dart';
import 'package:cat_app/src/features/home/widgets/error_container.dart';
import 'package:cat_app/src/features/home/widgets/image_container.dart';

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
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (catController.catImageUrl != null) {
                      await favoritesController.markAsFavorite(catController.catImageUrl!, widget.user.uid, context);
                    }
                  },
                  child: Text(
                    "Als Favorit markieren",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await catController.loadCatImage();
                  },
                  child: Text(
                    "Nächstes Bild",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Spacer(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
