import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class LocationScreen extends StatelessWidget {
  final TabController tabController;

  const LocationScreen({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(
                      text: 'Where Are You?',
                    ),
                    CustomTextField(
                      hint: 'ENTER YOUR LOCATION',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(
                                  location: value,
                                ),
                              ),
                            );
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: 6,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      unselectedColor: Theme.of(context).colorScheme.background,
                    ),
                    const SizedBox(height: 10),
                    CustomButton(
                      tabController: tabController,
                      text: 'NEXT STEP',
                    ),
                  ],
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
    );
  }
}
