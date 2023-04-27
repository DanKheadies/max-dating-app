import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class ProfileTextField extends StatelessWidget {
  final String title;
  final String value;
  final Function(String?) onChanged;

  const ProfileTextField({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(height: 10),
              state.isEditingOn
                  ? CustomTextField(
                      initialValue: value,
                      padding: EdgeInsets.zero,
                      onChanged: onChanged,
                    )
                  : Text(
                      value,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            height: 1.5,
                          ),
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
