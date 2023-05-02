import 'package:flutter/material.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/screens/chat_screen.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({
    super.key,
    required this.activeMatches,
  });

  final List<Match> activeMatches;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: activeMatches.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(
              ChatScreen.routeName,
              arguments: activeMatches[index],
            );
          },
          child: Row(
            children: [
              UserImageSmall(
                height: 75,
                width: 75,
                imageUrl: activeMatches[index].matchUser.imageUrls[0],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeMatches[index].matchUser.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    activeMatches[index].chat.messages[0].message,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    activeMatches[index].chat.messages[0].timeString,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
