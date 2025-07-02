import 'package:firebase_test_app/src/features/auth/controller/user_controller.dart';
import 'package:firebase_test_app/src/features/auth/repositories/auth_repository.dart';

import 'package:firebase_test_app/src/features/favorites/favorites_controller.dart';
import 'package:firebase_test_app/src/features/favorites/presentation/screens/favorites_gallery_screen.dart';
import 'package:firebase_test_app/src/features/home/controller/cat_controller.dart';

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
    final catController = context.watch<CatController>();
    final favoritesController = context.read<FavoritesController>();
    final userController = context.watch<UserController>();
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              userController.isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      "Hallo $userName",
                      style: Theme.of(context).textTheme.displaySmall,
                      textAlign: TextAlign.center,
                    ),
              SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: AnimatedBuilder(
                  animation: catController,
                  builder: (context, _) {
                    if (catController.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (catController.catImageUrl == null) {
                      return const Center(
                        child: Text("Kein Bild geladen"),
                      );
                    }

                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      height: 400,
                      child: Image.network(
                        catController.catImageUrl!,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (catController.catImageUrl != null) {
                    final bool added =
                        await favoritesController.markAsFavorite(catController.catImageUrl!, widget.user.uid);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(added ? "Zu Favoriten hinzugefügt" : "Bereits als Favorit gespeichert"),
                        ),
                      );
                    }
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
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => FavoritesGalleryScreen(uid: widget.user.uid),
                  ),
                ),
                child: Text(
                  "Zu Favoriten",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
