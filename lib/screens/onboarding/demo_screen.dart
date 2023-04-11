import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class DemoScreen extends StatelessWidget {
  final TabController tabController;

  const DemoScreen({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        print('daco');
        print(state);
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
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextHeader(
                      text: 'What\'s Your Gender?',
                    ),
                    const SizedBox(height: 20),
                    CustomCheckbox(
                      text: 'MALE',
                      value: state.user.gender == 'Male',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(
                                  gender: 'Male',
                                ),
                              ),
                            );
                      },
                    ),
                    CustomCheckbox(
                      text: 'FEMALE',
                      value: state.user.gender == 'Female',
                      onChanged: (bool? newValue) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(
                                  gender: 'Female',
                                ),
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: 100),
                    const CustomTextHeader(
                      text: 'What\'s Your Age?',
                    ),
                    CustomTextField(
                      // controller: TextEditingController(),
                      hint: 'ENTER YOUR AGE',
                      onChanged: (value) {
                        context.read<OnboardingBloc>().add(
                              UpdateUser(
                                user: state.user.copyWith(
                                  age: int.parse(value),
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
                      currentStep: 3,
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
