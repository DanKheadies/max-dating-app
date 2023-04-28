import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';

class GenderPereference extends StatelessWidget {
  const GenderPereference({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (conext, state) {
        if (state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Show me: ',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Row(
                children: [
                  Checkbox(
                    value: state.user.genderPreference!.contains('Male'),
                    onChanged: (value) {
                      if (state.user.genderPreference!.contains('Male')) {
                        context.read<ProfileBloc>().add(
                              UpdateUserProfile(
                                user: state.user.copyWith(
                                  genderPreference:
                                      List.from(state.user.genderPreference!)
                                        ..remove('Male'),
                                ),
                              ),
                            );
                        context.read<ProfileBloc>().add(
                              SaveProfile(
                                user: state.user,
                              ),
                            );
                      } else {
                        context.read<ProfileBloc>().add(
                              UpdateUserProfile(
                                user: state.user.copyWith(
                                  genderPreference:
                                      List.from(state.user.genderPreference!)
                                        ..add('Male'),
                                ),
                              ),
                            );
                        context.read<ProfileBloc>().add(
                              SaveProfile(
                                user: state.user,
                              ),
                            );
                      }
                    },
                    visualDensity: VisualDensity.compact,
                  ),
                  Text(
                    'Men',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: state.user.genderPreference!.contains('Female'),
                    onChanged: (value) {
                      if (state.user.genderPreference!.contains('Female')) {
                        context.read<ProfileBloc>().add(
                              UpdateUserProfile(
                                user: state.user.copyWith(
                                  genderPreference:
                                      List.from(state.user.genderPreference!)
                                        ..remove('Female'),
                                ),
                              ),
                            );
                        context.read<ProfileBloc>().add(
                              SaveProfile(
                                user: state.user,
                              ),
                            );
                      } else {
                        context.read<ProfileBloc>().add(
                              UpdateUserProfile(
                                user: state.user.copyWith(
                                  genderPreference:
                                      List.from(state.user.genderPreference!)
                                        ..add('Female'),
                                ),
                              ),
                            );
                        context.read<ProfileBloc>().add(
                              SaveProfile(
                                user: state.user,
                              ),
                            );
                      }
                    },
                    visualDensity: VisualDensity.compact,
                  ),
                  Text(
                    'Women',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          );
        } else {
          return const Center(
            child: Text('Something went wrong.'),
          );
        }
      },
    );
  }
}
