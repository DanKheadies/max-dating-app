import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/location_model.dart';
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
              ? const LoginScreen()
              : BlocProvider(
                  create: (context) => ProfileBloc(
                    authBloc: BlocProvider.of<AuthBloc>(context),
                    databaseRepository: context.read<DatabaseRepository>(),
                    locationRepository: context.read<LocationRepository>(),
                  )..add(
                      LoadProfile(
                        userId: context.read<AuthBloc>().state.authUser!.uid,
                      ),
                    ),
                  child: const ProfileScreen(),
                );
        });
  }

  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'PROFILE',
        actionsIcons: [
          Icons.message,
          Icons.settings,
        ],
        actionsRoutes: [
          MatchesScreen.routeName,
          SettingsScreen.routeName,
        ],
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            // TODO: takes a bit of time to load (?)
            if (state is ProfileLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomElevatedButton(
                          text: 'View',
                          beginColor: state.isEditingOn
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                          endColor: state.isEditingOn
                              ? Colors.white
                              : Theme.of(context).colorScheme.secondary,
                          textColor: state.isEditingOn
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          width: MediaQuery.of(context).size.width * 0.45,
                          onPressed: () {
                            context.read<ProfileBloc>().add(
                                  SaveProfile(
                                    user: state.user,
                                  ),
                                );
                          },
                        ),
                        const SizedBox(width: 10),
                        CustomElevatedButton(
                          text: 'Edit',
                          beginColor: state.isEditingOn
                              ? Theme.of(context).colorScheme.primary
                              : Colors.white,
                          endColor: state.isEditingOn
                              ? Theme.of(context).colorScheme.secondary
                              : Colors.white,
                          textColor: state.isEditingOn
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary,
                          width: MediaQuery.of(context).size.width * 0.45,
                          onPressed: () {
                            context.read<ProfileBloc>().add(
                                  const EditProfile(
                                    isEditingOn: true,
                                  ),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileTextField(
                          title: 'Biography',
                          value: state.user.bio,
                          onChanged: (value) {
                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                    user: state.user.copyWith(
                                      bio: value,
                                    ),
                                  ),
                                );
                          },
                        ),
                        ProfileTextField(
                          title: 'Age',
                          value: '${state.user.age}',
                          onChanged: (value) {
                            if (value == null || value == '') return;

                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                    user: state.user.copyWith(
                                      age: int.parse(value),
                                    ),
                                  ),
                                );
                          },
                        ),
                        ProfileTextField(
                          title: 'Job Title',
                          value: state.user.jobTitle,
                          onChanged: (value) {
                            context.read<ProfileBloc>().add(
                                  UpdateUserProfile(
                                    user: state.user.copyWith(
                                      jobTitle: value,
                                    ),
                                  ),
                                );
                          },
                        ),
                        const ProfilePictures(),
                        const ProfileInterests(),
                        ProfileLocation(
                          title: 'Location',
                          value: state.user.location!.name,
                        ),
                        const SignOut(),
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
