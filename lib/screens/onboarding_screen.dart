import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/cubits/cubits.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/screens/screens.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => SignUpCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OnboardingBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              locationRepository: context.read<LocationRepository>(),
              storageRepository: context.read<StorageRepository>(),
            ),
          ),
        ],
        child: const OnboardingScreen(),
      ),
    );
  }

  const OnboardingScreen({super.key});

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Demographics'),
    Tab(text: 'Pictures'),
    Tab(text: 'Biography'),
    Tab(text: 'Location'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Builder(
        builder: (context) {
          final TabController tabController = DefaultTabController.of(context);

          context.read<OnboardingBloc>().add(
                StartOnboarding(
                  tabController: tabController,
                ),
              );

          return Scaffold(
            appBar: const CustomAppBar(
              title: 'ARROW',
              hasActions: false,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 50,
              ),
              child: BlocBuilder<OnboardingBloc, OnboardingState>(
                builder: (context, state) {
                  if (state is OnboardingLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is OnboardingLoaded) {
                    return TabBarView(
                      children: [
                        StartScreen(state: state),
                        EmailScreen(state: state),
                        DemoScreen(state: state),
                        PicturesScreen(state: state),
                        BioScreen(state: state),
                        LocationScreen(state: state),
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
            resizeToAvoidBottomInset: false,
          );
        },
      ),
    );
  }
}
