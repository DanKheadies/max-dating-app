import 'package:flutter/material.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/screens/chat_screen.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class MatchesList extends StatelessWidget {
  const MatchesList({
    super.key,
    required this.inactiveMatches,
  });

  final List<Match> inactiveMatches;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: inactiveMatches.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                ChatScreen.routeName,
                arguments: inactiveMatches[index],
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
              ),
              child: Column(
                children: [
                  // UserImageSmall(
                  //   height: 75,
                  //   width: 75,
                  //   imageUrl: inactiveMatches[index].matchUser.imageUrls[0],
                  // ),
                  UserImage.small(
                    width: 70,
                    height: 70,
                    url: inactiveMatches[index].matchUser.imageUrls[0],
                  ),
                  Text(
                    inactiveMatches[index].matchUser.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
