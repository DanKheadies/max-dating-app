import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/config/config.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SwipeBloc()
            ..add(
              LoadUsersEvent(
                users: User.users,
              ),
            ),
        ),
      ],
      child: MaterialApp(
        title: 'Max Dating App',
        theme: theme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: ProfileScreen.routeName,
      ),
    );
  }
}
