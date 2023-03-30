import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
// import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const HomeScreen(),
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
                    feedback: UserCard(user: state.users[0]),
                    childWhenDragging: UserCard(user: state.users[1]),
                    onDragEnd: (drag) {
                      if (drag.velocity.pixelsPerSecond.dx < 0) {
                        print('Swiped left');
                        context.read<SwipeBloc>().add(
                              SwipeLeftEvent(
                                user: state.users[0],
                              ),
                            );
                      } else {
                        print('Swiped right');
                        context.read<SwipeBloc>().add(
                              SwipeRightEvent(
                                user: state.users[0],
                              ),
                            );
                      }
                    },
                    child: UserCard(user: state.users[0]),
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
                          print('Swiped left');
                          context.read<SwipeBloc>().add(
                                SwipeLeftEvent(
                                  user: state.users[0],
                                ),
                              );
                        },
                        child: ChoiceButton(
                          // width: 60,
                          // height: 60,
                          // size: 25,
                          // hasGradient: false,
                          color: Theme.of(context).colorScheme.secondary,
                          icon: Icons.clear_rounded,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print('Swiped right');
                          context.read<SwipeBloc>().add(
                                SwipeRightEvent(
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
                        // width: 60,
                        // height: 60,
                        // size: 25,
                        // hasGradient: false,
                        color: Theme.of(context).colorScheme.primary,
                        icon: Icons.watch_later,
                      ),
                    ],
                  ),
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
