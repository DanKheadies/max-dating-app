import 'package:flutter/material.dart';

import 'package:max_dating_app/models/models.dart';

class MessageAppBar extends StatelessWidget with PreferredSizeWidget {
  const MessageAppBar({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.background,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Column(
        children: [
          CircleAvatar(
            radius: 15,
            backgroundImage: NetworkImage(match.matchUser.imageUrls[0]),
          ),
          Text(
            match.matchUser.name,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
