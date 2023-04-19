import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class MatchesScreen extends StatelessWidget {
  static const String routeName = '/matches';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (context) => MatchBloc(
          databaseRepository: context.read<DatabaseRepository>(),
        )..add(
            LoadMatches(
              user: context.read<AuthBloc>().state.user!,
            ),
          ),
        child: const MatchesScreen(),
      ),
    );
  }

  const MatchesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'MATCHES',
      ),
      body: BlocBuilder<MatchBloc, MatchState>(
        builder: (context, state) {
          if (state is MatchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MatchLoaded) {
            final inactiveMatches =
                state.matches.where((match) => match.chat == null).toList();

            final activeMatches =
                state.matches.where((match) => match.chat != null).toList();

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Likes',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    MatchesList(inactiveMatches: inactiveMatches),
                    const SizedBox(height: 10),
                    Text(
                      'Your Chats',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    ChatsList(activeMatches: activeMatches),
                  ],
                ),
              ),
            );
          }
          if (state is MatchUnavailable) {
            return Column(
              children: [
                Text(
                  'No matches yet.',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 20),
                CustomElevatedButton(
                  text: 'BACK TO SWIPING',
                  beginColor: Theme.of(context).colorScheme.secondary,
                  endColor: Theme.of(context).colorScheme.primary,
                  textColor: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
    );
  }
}

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
            Navigator.pushNamed(
              context,
              '/chat',
              arguments: activeMatches[index],
            );
          },
          child: Row(
            children: [
              UserImageSmall(
                height: 75,
                width: 75,
                imageUrl: activeMatches[index].matchedUser.imageUrls[0],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activeMatches[index].matchedUser.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    activeMatches[index].chat![0].messages[0].message,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    activeMatches[index].chat![0].messages[0].timeString,
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
          return Column(
            children: [
              UserImageSmall(
                height: 75,
                width: 75,
                imageUrl: inactiveMatches[index].matchedUser.imageUrls[0],
              ),
              Text(
                inactiveMatches[index].matchedUser.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          );
        },
      ),
    );
  }
}
