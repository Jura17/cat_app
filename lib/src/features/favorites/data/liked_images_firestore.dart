import 'dart:convert';

import 'package:cat_app/src/features/auth/repositories/user_repository.dart';
import 'package:cat_app/src/features/favorites/models/liked_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class LikedImagesFirestore {
  final FirebaseFirestore db;
  final UserRepository userRepo;

  LikedImagesFirestore({
    required this.db,
    required this.userRepo,
  });

  Future<void> createImageDocument(String url, String uid) async {
    String urlAsdocId = encodeUrl(url);
    final likedImagedocRef = db.collection('likedImages').doc(urlAsdocId);
    final userDoc = await db.collection('users').doc(uid).get();
    final List<dynamic> favorites = userDoc.data()?['favoriteImageUrls'] ?? [];
    final bool alreadyFavoriteOfCurrentUser = favorites.contains(url);

    final likedImageDocSnapshot = await likedImagedocRef.get();

    if (likedImageDocSnapshot.exists && !alreadyFavoriteOfCurrentUser) {
      debugPrint('Exists but not liked by current user');
      // Image already exists, increment likeCount if not a favorite of current user yet
      await likedImagedocRef.update({'likeCount': FieldValue.increment(1)});
    }

    if (!likedImageDocSnapshot.exists) {
      // New image, set likeCount to 1
      final newImage = FirestoreImage(
        createdAt: DateTime.now(),
        url: url,
        likeCount: 1,
      );

      await db.collection('likedImages').doc(urlAsdocId).set(newImage.toMap());
    }
  }

  String encodeUrl(String url) {
    return base64Url.encode(utf8.encode(url));
  }

  Future<void> removeLike(String url, String uid) async {
    String urlAsdocId = encodeUrl(url);
    final likedImagedocRef = db.collection('likedImages').doc(urlAsdocId);
    final userDoc = await db.collection('users').doc(uid).get();
    final List<dynamic> favorites = userDoc.data()?['favoriteImageUrls'] ?? [];
    final bool alreadyFavoriteOfCurrentUser = favorites.contains(url);

    final likedImageDocSnapshot = await likedImagedocRef.get();

    if (likedImageDocSnapshot.exists && alreadyFavoriteOfCurrentUser) {
      debugPrint('Exists and liked by current user');
      // Image already exists, increment likeCount if not a favorite of current user yet
      await likedImagedocRef.update({'likeCount': FieldValue.increment(-1)});
    }
  }
}
