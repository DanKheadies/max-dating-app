import 'package:flutter/material.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // print('The Route is: ${settings.name}');
    // print(settings);

    switch (settings.name) {
      // case '/':
      // return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      // case SplashScreen.routeName:
      //   return SplashScreen.route();
      case UserScreen.routeName:
        // return UsersScreen.route();
        return UserScreen.route(
          user: settings.arguments as User,
        );
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case ChatScreen.routeName:
        return ChatScreen.route(
          userMatch: settings.arguments as UserMatch,
        );
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(appBar: AppBar(title: const Text('error'))),
      settings: const RouteSettings(name: '/error'),
    );
  }
}
