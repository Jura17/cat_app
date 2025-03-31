class DatabaseUser {
  final String email;
  final String name;
  // final DateTime lastLogin;
  // final List<String> favoriteImageUrls;

  DatabaseUser({
    required this.email,
    required this.name,
    // required this.lastLogin,
    // required this.favoriteImageUrls,
  });

  factory DatabaseUser.fromMap(Map<String, dynamic> map) {
    return DatabaseUser(
      email: map["email"],
      name: map["name"],
      // lastLogin: map["lastLogin"],
      // favoriteImageUrls: map["favoriteImageUrls"]
    );
  }
}
