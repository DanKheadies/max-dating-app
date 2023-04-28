import 'package:flutter/material.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/screens/screens.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    // print('The Route is: ${settings.name}');
    // print(settings);

    switch (settings.name) {
      case '/':
        // case SplashScreen.routeName:
        return SplashScreen.route();
      case ChatScreen.routeName:
        return ChatScreen.route(
            // userMatch: settings.arguments as Match,
            );
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LoginScreen.routeName:
        return LoginScreen.route();
      case MatchesScreen.routeName:
        return MatchesScreen.route();
      case OnboardingScreen.routeName:
        return OnboardingScreen.route();
      case ProfileScreen.routeName:
        return ProfileScreen.route();
      case SettingsScreen.routeName:
        return SettingsScreen.route();
      case UserScreen.routeName:
        return UserScreen.route(
          user: settings.arguments as User,
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
