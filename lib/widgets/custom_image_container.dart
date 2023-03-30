import 'package:flutter/material.dart';

class CustomImageContainer extends StatelessWidget {
  final TabController tabController;

  const CustomImageContainer({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
        right: 10,
      ),
      child: Container(
        height: 150,
        width: MediaQuery.of(context).size.width / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 1,
            // bottom: BorderSide(
            //   color: Theme.of(context).colorScheme.primary,
            //   width: 1,
            // ),
            // top: BorderSide(
            //   color: Theme.of(context).colorScheme.primary,
            //   width: 1,
            // ),
            // bottom: BorderSide(
            //   color: Theme.of(context).colorScheme.primary,
            //   width: 1,
            // ),
            // bottom: BorderSide(
            //   color: Theme.of(context).colorScheme.primary,
            //   width: 1,
            // ),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(
              Icons.add_circle,
              color: Theme.of(context).colorScheme.secondary,
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
