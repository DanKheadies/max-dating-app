import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  final TabController tabController;

  const LocationScreen({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 50,
      ),
      child: Container(),
    );
  }
}
