import 'package:cat_app/src/features/top_ten_images/presentation/top_ten_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cat_app/src/features/auth/repositories/auth_repository.dart';
import 'package:cat_app/src/features/favorites/presentation/screens/favorites_gallery_screen.dart';
import 'package:cat_app/src/features/fetch_images/screens/home_screen.dart';
import 'package:flutter/material.dart';

class NavigationScaffold extends StatefulWidget {
  const NavigationScaffold({
    super.key,
    required this.authRepository,
    required this.user,
  });

  final AuthRepository authRepository;
  final User user;

  @override
  State<NavigationScaffold> createState() => _NavigationScaffoldState();
}

class _NavigationScaffoldState extends State<NavigationScaffold> {
  int _activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomeScreen(
        user: widget.user,
        authRepository: widget.authRepository,
      ),
      TopTenScreen(),
      FavoritesGalleryScreen(uid: widget.user.uid)
    ];

    return Scaffold(
      body: pages[_activeIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _activeIndex,
        onTap: (value) => setState(() {
          _activeIndex = value;
        }),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: 'Trending'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
      ),
    );
  }
}
