import 'package:flutter/material.dart';

class UserImageSmall extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const UserImageSmall({
    super.key,
    required this.imageUrl,
    this.height = 60,
    this.width = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: const EdgeInsets.only(
        top: 8,
        right: 8,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
