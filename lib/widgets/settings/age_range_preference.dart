import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';

class AgeRangePereference extends StatelessWidget {
  const AgeRangePereference({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (conext, state) {
        if (state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Age Range',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Row(
                children: [
                  Expanded(
                    child: RangeSlider(
                      values: RangeValues(
                        state.user.ageRangePreference![0].toDouble(),
                        state.user.ageRangePreference![1].toDouble(),
                      ),
                      min: 18,
                      max: 100,
                      activeColor: Theme.of(context).colorScheme.primary,
                      inactiveColor: Theme.of(context).colorScheme.primary,
                      onChanged: (rangeValues) {
                        context.read<ProfileBloc>().add(
                              UpdateUserProfile(
                                user: state.user.copyWith(
                                  ageRangePreference: [
                                    rangeValues.start.toInt(),
                                    rangeValues.end.toInt(),
                                  ],
                                ),
                              ),
                            );
                      },
                      onChangeEnd: (newRangeValues) {
                        context.read<ProfileBloc>().add(
                              SaveProfile(
                                user: state.user.copyWith(
                                  ageRangePreference: [
                                    newRangeValues.start.toInt(),
                                    newRangeValues.end.toInt(),
                                  ],
                                ),
                              ),
                            );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Text(
                      '${state.user.ageRangePreference![0]} - ${state.user.ageRangePreference![1]}',
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
