import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_test_app/features/auth/data/login_repository.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.user,
    required this.loginRepository,
  });
  final User user;
  final LoginRepository loginRepository;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Text(
                  "Name: ${data["name"] ?? ""}",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  "Age: ${data["age"] ?? ""}",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  "City: ${data["city"] ?? ""}",
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ],
            ),
            Column(
              children: [
                // ElevatedButton(onPressed: addData, child: Text("Add Data")),
                // ElevatedButton(
                //   onPressed: () async {
                //     await readData();
                //   },
                //   child: Text("Read Data"),
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // Future<void> addData() async {
  //   await firestore.collection("users").doc("testUser").set({
  //     "name": "John Doe",
  //     "age": 34,
  //     "city": "Berlin",
  //   });
  // }

  // Future<void> readData() async {
  //   try {
  //     DocumentSnapshot doc = await firestore.collection("users").doc("testUser").get();

  //     if (doc.exists) {
  //       setState(() {
  //         data = doc.data() as Map<String, dynamic>;
  //       });
  //     }
  //   } catch (e) {
  //     print("Error fetching document: $e");
  //   }
  // }
}
