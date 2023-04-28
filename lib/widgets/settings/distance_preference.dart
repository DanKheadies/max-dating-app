import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';

class DistancePreference extends StatelessWidget {
  const DistancePreference({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (conext, state) {
        if (state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Maximum Distance',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: state.user.distancePreference!.toDouble(),
                      min: 0,
                      max: 100,
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveColor: Theme.of(context).colorScheme.primary,
                      onChanged: (value) {
                        context.read<ProfileBloc>().add(
                              UpdateUserProfile(
                                user: state.user.copyWith(
                                  distancePreference: value.toInt(),
                                ),
                              ),
                            );
                      },
                      onChangeEnd: (newValue) {
                        context.read<ProfileBloc>().add(
                              SaveProfile(
                                user: state.user.copyWith(
                                  distancePreference: newValue.toInt(),
                                ),
                              ),
                            );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      '${state.user.distancePreference} km',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
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
