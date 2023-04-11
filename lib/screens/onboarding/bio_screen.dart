import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class BioScreen extends StatelessWidget {
  final TabController tabController;

  const BioScreen({
    super.key,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = TextEditingController();

    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is OnboardingLoaded) {
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
                    const SizedBox(height: 100),
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
        } else {
          return const Center(
            child: Text('Something went wrong.'),
          );
        }
      },
    );
  }
}
