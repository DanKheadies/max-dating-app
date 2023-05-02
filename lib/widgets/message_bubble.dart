import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({
    super.key,
    required this.message,
    required this.isFromCurrentUser,
  });

  final String message;
  final bool isFromCurrentUser;

  @override
  Widget build(BuildContext context) {
    AlignmentGeometry alignment =
        isFromCurrentUser ? Alignment.topRight : Alignment.topLeft;
    Color color = isFromCurrentUser
        ? Theme.of(context).colorScheme.background
        : Theme.of(context).primaryColor;
    TextStyle? textStyle = isFromCurrentUser
        ? Theme.of(context).textTheme.titleLarge
        : Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white,
            );

    return Align(
      alignment: alignment,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Text(
          message,
          style: textStyle,
        ),
      ),
    );
  }
}
