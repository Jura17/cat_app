import 'package:cat_app/firebase_options.dart';
import 'package:cat_app/src/features/ai_integration/controller/gemini_controller.dart';
import 'package:cat_app/src/features/ai_integration/data/gemini_api.dart';
import 'package:cat_app/src/features/auth/controller/user_controller.dart';
import 'package:cat_app/src/features/top_ten_images/controller/top_ten_controller.dart';
import 'package:cat_app/src/features/top_ten_images/data/top_ten_firestore.dart';
import 'package:cat_app/src/features/favorites/favorites_controller.dart';
import 'package:cat_app/src/features/favorites/favorites_service.dart';
import 'package:cat_app/src/features/fetch_images/controller/cat_controller.dart';
import 'package:cat_app/src/features/fetch_images/data/cat_api.dart';
import 'package:cat_app/src/features/fetch_images/repository/cat_repository.dart';
import 'package:cat_app/src/features/fetch_images/service/cat_service.dart';
import 'package:cat_app/src/features/top_ten_images/service/top_ten_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';
import 'package:cat_app/src/features/auth/repositories/firebase_auth_repository.dart';
import 'package:cat_app/src/features/auth/repositories/firestore_user_repository.dart';

import 'package:cat_app/src/features/auth/repositories/user_repository.dart';

import 'package:cat_app/src/main_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
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
  final catController = CatController(catService);
  final geminiApi = GeminiApi(catController);
  final topTenImagesFirestore = TopTenFirestore(db: firestore, userRepo: userRepository);
  final favoritesService = FavoritesService(userRepo: userRepository, likedImagesFirestore: topTenImagesFirestore);
  final topTenService = TopTenService(userRepo: userRepository, likedImagesFirestore: topTenImagesFirestore);
  final topTenController = TopTenController(topTenService);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserController(userRepository)),
        ChangeNotifierProvider(
          create: (_) {
            catController.loadCatImage();
            return catController;
          },
        ),
        ChangeNotifierProvider(create: (_) => GeminiController(geminiApi)),
        ChangeNotifierProvider(create: (_) {
          topTenController.loadTopTenImages();
          return TopTenController(topTenService);
        }),
        ChangeNotifierProvider(create: (_) => FavoritesController(favoritesService)),
      ],
      child: MainApp(
        authRepository: authRepository,
        userRepository: userRepository,
      ),
    ),
  );
}
