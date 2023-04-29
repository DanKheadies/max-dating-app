import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class BioScreen extends StatelessWidget {
  final OnboardingLoaded state;

  const BioScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      currentStep: 5,
      onPressed: () {
        context.read<OnboardingBloc>().add(
              ContinueOnboarding(
                user: state.user,
              ),
            );
      },
      children: [
        const CustomTextHeader(
          text: 'Describe Yourself a Bit',
        ),
        CustomTextField(
          hint: 'ENTER YOUR BIO',
          onChanged: (value) {
            context.read<OnboardingBloc>().add(
                  UpdateUser(
                    user: state.user.copyWith(
                      bio: value,
                    ),
                  ),
                );
          },
        ),
        const SizedBox(height: 40),
        const CustomTextHeader(
          text: 'What do you do?',
        ),
        CustomTextField(
          hint: 'ENTER YOUR JOB TITLE',
          onChanged: (value) {
            context.read<OnboardingBloc>().add(
                  UpdateUser(
                    user: state.user.copyWith(
                      jobTitle: value,
                    ),
                  ),
                );
          },
        ),
        const SizedBox(height: 40),
        const CustomTextHeader(
          text: 'What Do You Like?',
        ),
        Row(
          children: const [
            CustomTextContainer(text: 'MUSIC'),
            CustomTextContainer(text: 'ECONMOICS'),
            CustomTextContainer(text: 'ART'),
            CustomTextContainer(text: 'POLITICS'),
          ],
        ),
        Row(
          children: const [
            CustomTextContainer(text: 'NATURE'),
            CustomTextContainer(text: 'HIKING'),
            CustomTextContainer(text: 'FOOTBALL'),
          ],
        ),
        Row(
          children: const [
            CustomTextContainer(text: 'MOVIES'),
          ],
        ),
      ],
    );
  }
}
