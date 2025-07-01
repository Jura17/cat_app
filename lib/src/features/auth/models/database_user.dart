import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUser {
  final String name;
  final DateTime createdAt;
  final DateTime lastLogin;
  final List<String> favoriteImageUrls;

  DatabaseUser({
    required this.name,
    required this.createdAt,
    required this.lastLogin,
    required this.favoriteImageUrls,
  });

  factory DatabaseUser.fromMap(Map<String, dynamic> map) {
    return DatabaseUser(
      name: map["name"] as String,
      createdAt: (map["createdAt"] as Timestamp).toDate(),
      lastLogin: map["lastLogin"] != null ? (map["lastLogin"] as Timestamp).toDate() : DateTime.now(),
      favoriteImageUrls: List<String>.from(map["favoriteImageUrls"] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "createdAt": Timestamp.fromDate(createdAt),
      "lastLogin": Timestamp.fromDate(lastLogin),
      "favoriteImageUrls": favoriteImageUrls
    };
  }
}
