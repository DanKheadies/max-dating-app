import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/widgets/widgets.dart';

class EmailVerificationScreen extends StatelessWidget {
  final TabController tabController;

  const EmailVerificationScreen({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
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
              CustomTextHeader(
                tabController: tabController,
                text: 'Did You Get The Verification Code?',
              ),
              CustomTextField(
                tabController: tabController,
                text: 'ENTER YOUR CODE',
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 2,
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
  }
}
