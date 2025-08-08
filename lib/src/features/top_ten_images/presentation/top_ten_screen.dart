import 'package:cat_app/src/features/top_ten_images/controller/top_ten_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TopTenScreen extends StatefulWidget {
  const TopTenScreen({super.key});

  @override
  State<TopTenScreen> createState() => _TopTenScreenState();
}

class _TopTenScreenState extends State<TopTenScreen> {
  @override
  Widget build(BuildContext context) {
    final topTenController = context.watch<TopTenController>();
    final List<String> topTenImages = topTenController.topTenImages ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Top Ten Cats"),
      ),
      body: topTenImages.isEmpty
          ? Text("Not a single cat has got a like yet :(")
          : ListView.builder(
              itemCount: topTenImages.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("No. ${index + 1}", style: TextStyle(fontSize: 18)),
                      Image.network(
                        topTenImages[index],
                        fit: BoxFit.cover,
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
