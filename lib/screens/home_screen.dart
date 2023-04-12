import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
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
            : const HomeScreen();
      },
    );
  }

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'DISCOVER',
      ),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SwipeLoaded) {
            var userCount = state.users.length;
            return Column(
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
                    childWhenDragging: userCount > 1
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
            );
          }
          if (state is SwipeError) {
            return Center(
              child: Text(
                'There aren\'t any more users.',
                style: Theme.of(context).textTheme.headlineMedium,
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
