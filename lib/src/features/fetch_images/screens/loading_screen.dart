import 'package:firebase_auth/firebase_auth.dart';
import 'package:cat_app/src/features/auth/controller/user_controller.dart';
import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';
import 'package:cat_app/src/features/favorites/favorites_controller.dart';

import 'package:cat_app/src/navigation_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({
    super.key,
    required this.authRepository,
    required this.user,
  });

  final AuthRepository authRepository;
  final User user;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final Future<void> _initFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = initUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: _initFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text("An error occurred while loading the user data: ${snapshot.error}"),
              );
            }

            return NavigationScaffold(
              user: widget.user,
              authRepository: widget.authRepository,
            );
          },
        ),
      ),
    );
  }

  Future<void> initUserData(BuildContext context) async {
    await context.read<UserController>().loadUser(widget.user.uid);
    if (context.mounted) await context.read<FavoritesController>().loadFavorites(widget.user.uid);
  }
}
