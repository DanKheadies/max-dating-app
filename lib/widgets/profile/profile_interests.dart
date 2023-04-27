import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class ProfileInterests extends StatelessWidget {
  const ProfileInterests({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Interests',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Row(
                children: const [
                  CustomTextContainer(text: 'MUSIC'),
                  CustomTextContainer(text: 'SPORTS'),
                  CustomTextContainer(text: 'SQUIDWARD'),
                  CustomTextContainer(text: 'MSDOS'),
                ],
              ),
              const SizedBox(height: 10),
            ],
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
