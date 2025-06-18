import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:firebase_test_app/features/auth/data/firebase_auth_repository.dart';
import 'package:firebase_test_app/features/auth/data/firestore_user_repository.dart';

import 'package:firebase_test_app/features/auth/data/user_repository.dart';
import 'package:firebase_test_app/firebase_options.dart';

import 'package:firebase_test_app/main_app.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final UserRepository userRepository = FirestoreUserRepository(firestore);
  final AuthRepository authRepository = FirebaseAuthRepository(auth: auth, userRepository: userRepository);

  runApp(MainApp(
    authRepository: authRepository,
    userRepository: userRepository,
  ));
}

// API-Keys protection
// 1.
// 2. Firestore security rules
// 3. Firebase app check
// git rm --cached /datei/
