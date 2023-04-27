import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class ProfilePictures extends StatelessWidget {
  const ProfilePictures({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pictures',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: state.user.imageUrls.isNotEmpty ? 125 : 0,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: state.user.imageUrls.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 5,
                      ),
                      child: UserImage.small(
                        width: 100,
                        url: state.user.imageUrls[index],
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    );
                  },
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
