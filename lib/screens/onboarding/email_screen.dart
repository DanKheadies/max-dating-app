import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/cubits/cubits.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class EmailScreen extends StatelessWidget {
  final TabController tabController;

  const EmailScreen({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
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
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 1,
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
      },
    );
  }
}
