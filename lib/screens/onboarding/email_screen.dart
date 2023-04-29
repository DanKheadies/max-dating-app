import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/cubits/cubits.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class EmailScreen extends StatelessWidget {
  final OnboardingLoaded state;

  const EmailScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingLayout(
      currentStep: 2,
      onPressed: () async {
        var onboardContext = context.read<OnboardingBloc>();
        var signUpContext = context.read<SignUpCubit>();

        await context.read<SignUpCubit>().signUpWithCredentials();
        onboardContext.add(
          ContinueOnboarding(
            isSignup: true,
            user: User.empty.copyWith(
              id: signUpContext.state.user!.uid,
            ),
          ),
        );
      },
      children: [
        const CustomTextHeader(
          text: 'What\'s Your Email Address?',
        ),
        CustomTextField(
          onChanged: (value) {
            context.read<SignUpCubit>().emailChanged(value);
          },
          hint: 'ENTER YOUR EMAIL',
        ),
        const SizedBox(height: 75),
        const CustomTextHeader(
          text: 'What\'s Your Email Address?',
        ),
        CustomTextField(
          onChanged: (value) {
            context.read<SignUpCubit>().passwordChanged(value);
          },
          hint: 'ENTER YOUR PASSWORD',
        ),
      ],
    );
  }
}
