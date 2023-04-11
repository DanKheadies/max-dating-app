import 'package:flutter/material.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class UserScreen extends StatelessWidget {
  static const String routeName = '/user';
  static Route route({
    required User user,
  }) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => UserScreen(user: user),
    );
  }

  final User user;

  const UserScreen({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Hero(
                    tag: 'user_image',
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: NetworkImage(user.imageUrls[0]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 60,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ChoiceButton(
                          color: Theme.of(context).colorScheme.secondary,
                          icon: Icons.clear_rounded,
                        ),
                        const ChoiceButton(
                          height: 80,
                          width: 80,
                          size: 30,
                          hasGradient: true,
                          color: Colors.white,
                          icon: Icons.favorite,
                        ),
                        ChoiceButton(
                          color: Theme.of(context).colorScheme.primary,
                          icon: Icons.watch_later,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}, ${user.age}',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  user.jobTitle,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                ),
                const SizedBox(height: 15),
                Text(
                  'About',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Text(
                  user.bio,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        height: 2,
                      ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Interests',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Row(
                  children: user.interests
                      .map(
                        (interest) => Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                            top: 5,
                            right: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.secondary,
                              ],
                            ),
                          ),
                          child: Text(
                            interest,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
