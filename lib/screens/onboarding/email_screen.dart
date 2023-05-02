import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

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
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, signUpState) {
        return OnboardingLayout(
          currentStep: 2,
          onPressed: () async {
            var onboardContext = context.read<OnboardingBloc>();
            var signUpContext = context.read<SignUpCubit>();

            if (Formz.validate([signUpState.email, signUpState.password])) {
              await context.read<SignUpCubit>().signUpWithCredentials();

              onboardContext.add(
                ContinueOnboarding(
                  isSignup: true,
                  user: User.empty.copyWith(
                    id: signUpContext.state.user!.uid,
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Check your email and password.'),
                ),
              );
            }
          },
          children: [
            const CustomTextHeader(
              text: 'What\'s Your Email Address?',
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) => previous.email != current.email,
              builder: (context, state) {
                return CustomTextField(
                  onChanged: (value) {
                    context.read<SignUpCubit>().emailChanged(value);
                  },
                  hint: 'ENTER YOUR EMAIL',
                  errorText: state.email.isNotValid && state.email.value != ''
                      ? 'The email is invalid.'
                      : null,
                );
              },
            ),
            const SizedBox(height: 75),
            const CustomTextHeader(
              text: 'What\'s Your Email Address?',
            ),
            BlocBuilder<SignUpCubit, SignUpState>(
              buildWhen: (previous, current) =>
                  previous.password != current.password,
              builder: (context, state) {
                return CustomTextField(
                  onChanged: (value) {
                    context.read<SignUpCubit>().passwordChanged(value);
                  },
                  hint: 'ENTER YOUR PASSWORD',
                  errorText:
                      state.password.isNotValid && state.password.value != ''
                          ? 'The password must contain at least 8 characters.'
                          : null,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
