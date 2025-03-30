import 'dart:convert';

import 'package:firebase_test_app/features/auth/data/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user,
    required this.loginRepository,
  });
  final User user;
  final AuthRepository loginRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: widget.loginRepository.logOut,
            child: Text(
              "Logout",
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Text(
                "Willkommen ${widget.user.email}",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              FutureBuilder(
                  future: fetchImage(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Fehler: ${snapshot.error}"),
                      );
                    } else if (!snapshot.hasData) {
                      return Center(child: Text("Keine Daten vorhanden."));
                    }
                    _imageUrl = snapshot.data;
                    return _imageUrl != null
                        ? SizedBox(
                            height: 400,
                            child: Image.network(
                              _imageUrl!,
                              fit: BoxFit.cover,
                            ))
                        : Center(child: Text("Bla"));
                  }),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: reloadImage,
                  child: Text(
                    "Zeig mir mehr",
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> fetchImage() async {
    final String uri = "https://api.thecatapi.com/v1/images/search";

    try {
      final response = await http.get(Uri.parse(uri));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);

        if (data.isNotEmpty) {
          return data[0]["url"];
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  void reloadImage() {
    fetchImage();
    setState(() {});
  }
}
