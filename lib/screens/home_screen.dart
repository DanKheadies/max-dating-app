import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/screens/screens.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) {
        return BlocProvider.of<AuthBloc>(context).state.status ==
                AuthStatus.unauthenticated
            ? const OnboardingScreen()
            : BlocProvider(
                create: (context) => SwipeBloc(
                  authBloc: context.read<AuthBloc>(),
                  databaseRepository: context.read<DatabaseRepository>(),
                )..add(LoadUsers()),
                child: const HomeScreen(),
              );
      },
    );
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwipeBloc, SwipeState>(
      builder: (context, state) {
        if (state is SwipeLoading) {
          return const Scaffold(
            appBar: CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is SwipeLoaded) {
          return SwipeLoadedHomeScreen(state: state);
        }
        if (state is SwipeMatched) {
          return SwipeMatchedHomeScreen(state: state);
        }
        if (state is SwipeError) {
          return Scaffold(
            appBar: const CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Center(
              child: Text(
                'There aren\'t any more users.',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          );
        } else {
          return const Scaffold(
            appBar: CustomAppBar(
              title: 'DISCOVER',
            ),
            body: Center(
              child: Text('Something went wrong.'),
            ),
          );
        }
      },
    );
  }
}

class SwipeLoadedHomeScreen extends StatelessWidget {
  const SwipeLoadedHomeScreen({
    super.key,
    required this.state,
  });

  final SwipeLoaded state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'DISCOVER',
      ),
      body: Column(
        children: [
          InkWell(
            onDoubleTap: () {
              Navigator.pushNamed(
                context,
                '/user',
                arguments: state.users[0],
              );
            },
            child: Draggable(
              data: state.users[0],
              feedback: UserCard(user: state.users[0]),
              childWhenDragging: state.users.length > 1
                  ? UserCard(user: state.users[1])
                  : const SizedBox(),
              onDragEnd: (drag) {
                if (drag.velocity.pixelsPerSecond.dx < 0) {
                  context.read<SwipeBloc>().add(
                        SwipeLeft(
                          user: state.users[0],
                        ),
                      );
                } else {
                  context.read<SwipeBloc>().add(
                        SwipeRight(
                          user: state.users[0],
                        ),
                      );
                }
              },
              child: UserCard(
                user: state.users[0],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 60,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    context.read<SwipeBloc>().add(
                          SwipeLeft(
                            user: state.users[0],
                          ),
                        );
                  },
                  child: ChoiceButton(
                    color: Theme.of(context).colorScheme.secondary,
                    icon: Icons.clear_rounded,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.read<SwipeBloc>().add(
                          SwipeRight(
                            user: state.users[0],
                          ),
                        );
                  },
                  child: const ChoiceButton(
                    width: 80,
                    height: 80,
                    size: 30,
                    hasGradient: true,
                    color: Colors.white,
                    icon: Icons.favorite,
                  ),
                ),
                ChoiceButton(
                  color: Theme.of(context).colorScheme.primary,
                  icon: Icons.watch_later,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SwipeMatchedHomeScreen extends StatelessWidget {
  const SwipeMatchedHomeScreen({
    super.key,
    required this.state,
  });

  final SwipeMatched state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congrats, it\'s a match!',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'You and ${state.user.name} have liked each other!',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        context.read<AuthBloc>().state.user!.imageUrls[0],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ClipOval(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.primary,
                        ],
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(
                        state.user.imageUrls[0],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              text: 'SEND A MESSAGE',
              beginColor: Colors.white,
              endColor: Colors.white,
              textColor: Theme.of(context).primaryColor,
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            CustomElevatedButton(
              text: 'BACK TO SWIPING',
              beginColor: Theme.of(context).primaryColor,
              endColor: Theme.of(context).colorScheme.secondary,
              textColor: Colors.white,
              onPressed: () {
                context.read<SwipeBloc>().add(
                      LoadUsers(),
                    );
              },
            ),
          ],
        ),
      ),
    );
  }
}
