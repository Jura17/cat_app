import 'package:firebase_test_app/src/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/src/features/auth/data/user_repository.dart';
import 'package:firebase_test_app/src/features/home/controller/cat_controller.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user,
    required this.authRepository,
    required this.userRepository,
  });
  final User user;
  final AuthRepository authRepository;
  final UserRepository userRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final catController = context.watch<CatController>();
    _imageUrl = catController.catImageUrl;

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: widget.authRepository.logOut,
            child: Text("Logout"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              FutureBuilder(
                future: widget.userRepository.getUser(widget.user.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Text("An error has occurred: ${snapshot.error}");
                  }
                  final userData = snapshot.data!;
                  return Text(
                    "Willkommen ${userData.name}",
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  );
                },
              ),
              SizedBox(height: 20),
              AnimatedBuilder(
                animation: catController,
                builder: (context, _) {
                  if (catController.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (catController.catImageUrl == null) {
                    return const Center(
                      child: Text("No image was fetched"),
                    );
                  }

                  return Center(
                    child: SizedBox(
                      height: 400,
                      child: Image.network(
                        _imageUrl!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Als Favorit markieren",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  setState(() {
                    catController.loadCatImage();
                  });
                },
                child: Text(
                  "Nächstes Bild",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
