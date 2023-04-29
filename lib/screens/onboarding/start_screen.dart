import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class StartScreen extends StatelessWidget {
  final OnboardingLoaded state;

  const StartScreen({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: SvgPicture.asset('assets/images/couple.svg'),
            ),
            const SizedBox(height: 50),
            Text(
              'Welcome To Arrow',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20),
            Text(
              'Reloaded 13 of 962 libraries in 328ms (compile: 55 ms, reload: 112 ms, reassemble: 137 ms).',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    height: 1.5,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        CustomButton(
          text: 'START',
          onPressed: () {
            context.read<OnboardingBloc>().add(
                  ContinueOnboarding(
                    user: state.user,
                  ),
                );
          },
        ),
      ],
    );
  }
}
