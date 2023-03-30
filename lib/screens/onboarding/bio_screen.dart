import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/widgets/widgets.dart';

class BioScreen extends StatelessWidget {
  final TabController tabController;

  const BioScreen({
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
                text: 'Describe Yourself a Bit',
              ),
              CustomTextField(
                tabController: tabController,
                text: 'ENTER YOUR BIO',
              ),
              const SizedBox(height: 100),
              CustomTextHeader(
                tabController: tabController,
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
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 5,
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
