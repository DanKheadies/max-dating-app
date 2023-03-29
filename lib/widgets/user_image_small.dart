import 'package:flutter/material.dart';

class UserImageSmall extends StatelessWidget {
  final String imageUrl;

  const UserImageSmall({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: 75,
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
