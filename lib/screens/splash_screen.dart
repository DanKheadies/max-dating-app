import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/cubits/cubits.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/screens/screens.dart';
// import 'package:max_dating_app/widgets/widgets.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const SplashScreen(),
    );
  }

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    print('init splash');
    // RepositoryProvider.of<AuthRepository>(context).signOut();
  }

  @override
  Widget build(BuildContext context) {
    // return WillPopScope(
    //   onWillPop: () async => false,
    //   child: MultiBlocListener(
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          // NOTE: w/ no listenWhen, it autofires listener
          // TODO: still needs fixing; login not working
          // listenWhen: (previous, current) =>
          //     previous.authUser != current.authUser ||
          //     current.authUser == null ||
          //     current.authUser!.uid != '',
          listenWhen: (previous, current) {
            print('auth listening..');
            if (previous.authUser != current.authUser) {
              print('prev: ${previous.authUser}');
              print('curr: ${current.authUser}');
              return true;
            }
            if (current.authUser == null) {
              print('current IS null');
              return true;
            }
            if (current.authUser!.uid != '') {
              print('currId: ${current.authUser!.uid}');
              return true;
            }
            return false;
          },
          // true,
          listener: (context, state) {
            // TODO: not running after completed user registration b/c timing
            // Prob better to check the signup or login cubit?
            print('auth listener');
            // print(state.status);
            if (state.status == AuthStatus.unauthenticated ||
                state.status == AuthStatus.unknown) {
              Timer(
                const Duration(milliseconds: 1000),
                () => Navigator.of(context).pushNamed(
                  LoginScreen.routeName,
                ),
                // () => Navigator.of(context).pushNamedAndRemoveUntil(
                //   LoginScreen.routeName,
                //   ModalRoute.withName('/login'),
                //   // (route) => false,
                // ),
              );
            } else if (state.status == AuthStatus.authenticated) {
              Timer(
                const Duration(milliseconds: 1000),
                () => Navigator.of(context).pushNamedAndRemoveUntil(
                  HomeScreen.routeName,
                  (route) => false,
                ),
                // () => Navigator.of(context).pushNamed(
                //   HomeScreen.routeName,
                // ),
              );
            }
          },
        ),
        BlocListener<LoginCubit, LoginState>(
          listenWhen: (previous, current) {
            print('login listening..');
            if (previous.user != current.user) {
              print('prev: ${previous.user}');
              print('curr: ${current.user}');
              return true;
            }
            // if (current.user == null) {
            //   print('current not null');
            //   return true;
            // }
            // if (current.user!.uid != '') {
            //   print('currId: ${current.authUser!.uid}');
            //   return true;
            // }
            return false;
          },
          listener: (context, state) {
            print('login listener');
            print(state.status);
            // if (state.status == AuthStatus.unauthenticated ||
            //     state.status == AuthStatus.unknown) {
            //   Timer(
            //     const Duration(milliseconds: 1000),
            //     // () => Navigator.of(context).pushNamed(
            //     //   LoginScreen.routeName,
            //     // ),
            //     () => Navigator.of(context).pushNamedAndRemoveUntil(
            //       LoginScreen.routeName,
            //       ModalRoute.withName('/login'),
            //       // (route) => false,
            //     ),
            //   );
            // } else if (state.status == AuthStatus.authenticated) {
            //   Timer(
            //     const Duration(milliseconds: 1000),
            //     // () => Navigator.of(context).pushNamedAndRemoveUntil(
            //     //   HomeScreen.routeName,
            //     //   ModalRoute.withName('/home'),
            //     //   // (route) => false,
            //     // ),
            //     () => Navigator.of(context).pushNamed(
            //       HomeScreen.routeName,
            //     ),
            //   );
            // }
          },
        ),
      ],
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
                const SizedBox(height: 20),
                // const SignOut(),
                TextButton(
                  onPressed: () {
                    RepositoryProvider.of<AuthRepository>(context).signOut();
                    // Navigator.pushNamed(context, '/');
                  },
                  child: Center(
                    child: Text(
                      'Sign Out',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
