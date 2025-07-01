import 'package:firebase_test_app/src/features/favorites/favorites_controller.dart';
import 'package:firebase_test_app/src/features/favorites/favorites_service.dart';
import 'package:firebase_test_app/src/features/home/controller/cat_controller.dart';
import 'package:firebase_test_app/src/features/home/data/cat_api.dart';
import 'package:firebase_test_app/src/features/home/repository/cat_repository.dart';
import 'package:firebase_test_app/src/features/home/service/cat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test_app/src/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/src/features/auth/data/firebase_auth_repository.dart';
import 'package:firebase_test_app/src/features/auth/data/firestore_user_repository.dart';

import 'package:firebase_test_app/src/features/auth/data/user_repository.dart';
import 'package:firebase_test_app/src/firebase_options.dart';

import 'package:firebase_test_app/src/main_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserRepository userRepository = FirestoreUserRepository(firestore);
  final AuthRepository authRepository = FirebaseAuthRepository(auth: auth, userRepository: userRepository);
  final catApi = CatApi();
  final catRepo = CatRepository(catApi);
  final catService = CatService(catRepo);

  final favoritesService = FavoritesService(userRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) {
            final catController = CatController(catService);
            catController.initialize();
            return catController;
          },
        ),
        ChangeNotifierProvider(create: (_) => FavoritesController(favoritesService)),
      ],
      // create: (context) {

      //   final catController = CatController(catService);
      //   catController.initialize();
      //   return catController;
      // },
      child: MainApp(
        authRepository: authRepository,
        userRepository: userRepository,
      ),
    ),
  );
}

// API-Keys protection
// 1.
// 2. Firestore security rules
// 3. Firebase app check
// git rm --cached /datei/
