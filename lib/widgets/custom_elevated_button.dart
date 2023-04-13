import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final Color beginColor;
  final Color endColor;
  final Color textColor;
  final Function()? onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.beginColor,
    required this.endColor,
    required this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withAlpha(50),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(2, 2),
          ),
        ],
        gradient: LinearGradient(
          colors: [
            beginColor,
            endColor,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          fixedSize: const Size(200, 40),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: textColor,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
