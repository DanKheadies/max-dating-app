import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class DemoScreen extends StatelessWidget {
  final OnboardingLoaded state;

  const DemoScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      currentStep: 3,
      onPressed: () {
        context.read<OnboardingBloc>().add(
              ContinueOnboarding(
                user: state.user,
              ),
            );
      },
      children: [
        const CustomTextHeader(
          text: 'What\'s Your Name?',
        ),
        CustomTextField(
          hint: 'ENTER YOUR NAME',
          onChanged: (value) {
            context.read<OnboardingBloc>().add(
                  UpdateUser(
                    user: state.user.copyWith(
                      name: value,
                    ),
                  ),
                );
          },
        ),
        const SizedBox(height: 40),
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
        const SizedBox(height: 40),
        const CustomTextHeader(
          text: 'What\'s Your Age?',
        ),
        CustomTextField(
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
    );
  }
}
