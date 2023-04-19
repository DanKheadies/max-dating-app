import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/cubits/cubits.dart';
import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';

class CustomButton extends StatelessWidget {
  final TabController tabController;
  final String text;

  const CustomButton({
    super.key,
    required this.tabController,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: ElevatedButton(
        onPressed: () async {
          var suCon = context.read<SignUpCubit>();
          var onCon = context.read<OnboardingBloc>();

          if (tabController.index == 6) {
            // Navigator.pushNamed(context, '/');
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/',
              (route) => false,
            );
          } else {
            tabController.animateTo(tabController.index + 1);
          }

          if (tabController.index == 2) {
            await context.read<SignUpCubit>().signUpWithCredentials();

            User user = User.empty.copyWith(
              id: suCon.state.user!.uid,
              name: 'Waldo',
              interests: ['Water'],
              jobTitle: 'Sex Worker',
            );

            onCon.add(
              StartOnboarding(
                user: user,
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        child: SizedBox(
          width: double.infinity,
          child: Center(
            child: Text(
              text,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
