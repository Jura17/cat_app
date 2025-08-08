import 'package:flutter/material.dart';

class TopTenImageContainer extends StatelessWidget {
  const TopTenImageContainer({
    super.key,
    required this.topTenImages,
    required this.index,
  });

  final List<String> topTenImages;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Image.network(
          topTenImages[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
