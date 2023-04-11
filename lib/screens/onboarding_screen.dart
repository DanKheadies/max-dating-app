import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/cubits/cubits.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/screens/screens.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class OnboardingScreen extends StatelessWidget {
  static const String routeName = '/onboarding';
  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (_) => SignUpCubit(
          authRepository: context.read<AuthRepository>(),
        ),
        child: const OnboardingScreen(),
      ),
    );
  }

  const OnboardingScreen({super.key});

  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Start'),
    Tab(text: 'Email'),
    Tab(text: 'Email Verification'),
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
          tabController.addListener(() {
            if (!tabController.indexIsChanging) {}
          });

          return Scaffold(
            appBar: const CustomAppBar(
              title: 'ARROW',
              hasActions: false,
            ),
            body: TabBarView(
              children: [
                StartScreen(tabController: tabController),
                EmailScreen(tabController: tabController),
                EmailVerificationScreen(tabController: tabController),
                DemoScreen(tabController: tabController),
                PicturesScreen(tabController: tabController),
                BioScreen(tabController: tabController),
                LocationScreen(tabController: tabController),
              ],
            ),
          );
        },
      ),
    );
  }
}
