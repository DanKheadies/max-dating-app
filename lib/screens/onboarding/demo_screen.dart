import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/widgets/widgets.dart';

class DemoScreen extends StatelessWidget {
  final TabController tabController;

  const DemoScreen({
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextHeader(
                tabController: tabController,
                text: 'What\'s Your Gender?',
              ),
              const SizedBox(height: 10),
              CustomCheckbox(
                tabController: tabController,
                text: 'MALE',
              ),
              CustomCheckbox(
                tabController: tabController,
                text: 'FEMALE',
              ),
              const SizedBox(height: 100),
              CustomTextHeader(
                tabController: tabController,
                text: 'What\'s Your Age?',
              ),
              CustomTextField(
                tabController: tabController,
                text: 'ENTER YOUR AGE',
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
  }
}
