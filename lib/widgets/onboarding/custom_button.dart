import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;

  const CustomButton({
    super.key,
    required this.tabController,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          tabController.animateTo(tabController.index + 1);
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
