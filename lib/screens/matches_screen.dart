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
            final inactiveMatches = state.matches
                .where((match) => match.chat.messages.isEmpty)
                .toList();

            final activeMatches = state.matches
                .where((match) => match.chat.messages.isNotEmpty)
                .toList();

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
                    inactiveMatches.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text('Go back to swiping'),
                          )
                        : MatchesList(inactiveMatches: inactiveMatches),
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
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
              ),
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
