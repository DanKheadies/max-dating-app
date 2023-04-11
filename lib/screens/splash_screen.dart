import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SplashScreen(),
    );
  }

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          print('listening..');
          print(state.status);
          if (state.status == AuthStatus.unauthenticated) {
            Timer(
              const Duration(milliseconds: 1000),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                OnboardingScreen.routeName,
                ModalRoute.withName('/onboarding'),
                // (route) => false,
              ),
            );
          } else if (state.status == AuthStatus.authenticated) {
            Timer(
              const Duration(milliseconds: 1000),
              () => Navigator.of(context).pushNamedAndRemoveUntil(
                HomeScreen.routeName,
                ModalRoute.withName('/home'),
                // (route) => false,
              ),
            );
          }
        },
        child: Scaffold(
          body: SizedBox(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    height: 100,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'ARROW',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
