import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
// import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/screens/screens.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = '/profile';
  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? const OnboardingScreen()
              : const ProfileScreen();
        });
  }

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PROFILE',
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  UserImage.medium(
                    url: state.user.imageUrls[0],
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: LinearGradient(
                          colors: [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.1),
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Text(
                            state.user.name,
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TitleWithIcon(
                          title: 'Biography',
                          icon: Icons.edit,
                        ),
                        Text(
                          state.user.bio,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    height: 1.5,
                                  ),
                        ),
                        const TitleWithIcon(
                          title: 'Pictures',
                          icon: Icons.edit,
                        ),
                        SizedBox(
                          height: 125,
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
                        const TitleWithIcon(
                          title: 'Location',
                          icon: Icons.edit,
                        ),
                        Text(
                          state.user.location!.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    height: 1.5,
                                  ),
                        ),
                        const TitleWithIcon(
                          title: 'Interest',
                          icon: Icons.edit,
                        ),
                        Row(
                          children: [
                            CustomTextContainer(
                              text: state.user.interests[0],
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            RepositoryProvider.of<AuthRepository>(context)
                                .signOut();
                            Navigator.pushNamed(context, '/');
                          },
                          child: Center(
                            child: Text(
                              'Sign Out',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Something went wrong.'),
              );
            }
          },
        ),
      ),
    );
  }
}

class TitleWithIcon extends StatelessWidget {
  final String title;
  final IconData icon;

  const TitleWithIcon({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.displaySmall,
        ),
        IconButton(
          icon: Icon(icon),
          onPressed: () {},
        ),
      ],
    );
  }
}
