import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/widgets/widgets.dart';

class OnboardingLayout extends StatelessWidget {
  final List<Widget> children;
  final int currentStep;
  final Function()? onPressed;

  const OnboardingLayout({
    super.key,
    required this.children,
    required this.currentStep,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: constraints.minWidth,
              minHeight: constraints.minHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...children,
                  const Spacer(),
                  SizedBox(
                    height: 75,
                    child: StepProgressIndicator(
                      totalSteps: 6,
                      currentStep: currentStep,
                      selectedColor: Theme.of(context).colorScheme.primary,
                      unselectedColor: Theme.of(context).colorScheme.background,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CustomButton(
                    text: 'NEXT STEP',
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
