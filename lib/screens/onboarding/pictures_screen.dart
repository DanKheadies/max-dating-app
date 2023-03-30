import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/widgets/widgets.dart';

class PicturesScreen extends StatelessWidget {
  final TabController tabController;

  const PicturesScreen({
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
                text: 'Add 2 or More Pictures',
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                ],
              ),
              Row(
                children: [
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                  CustomImageContainer(tabController: tabController),
                ],
              ),
            ],
          ),
          Column(
            children: [
              StepProgressIndicator(
                totalSteps: 6,
                currentStep: 4,
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
