import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/config/config.dart';
import 'package:max_dating_app/cubits/cubits.dart';
import 'package:max_dating_app/firebase_options.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/auth/auth_repository.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/screens/screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (_) => DatabaseRepository(),
        ),
        RepositoryProvider(
          create: (_) => StorageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          // BlocProvider(
          //   create: (_) => ImagesBloc(
          //     // databaseRepository: context.read<DatabaseRepository>(),
          //     databaseRepository: DatabaseRepository(),
          //   )..add(
          //       LoadImages(),
          //     ),
          // ),
          BlocProvider(
            create: (context) => SignUpCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => OnboardingBloc(
              // databaseRepository: DatabaseRepository(),
              databaseRepository: context.read<DatabaseRepository>(),
              // storageRepository: StorageRepository(),
              storageRepository: context.read<StorageRepository>(),
              // )..add(
              //     StartOnboarding(),
            ),
          ),
          BlocProvider(
            create: (context) => SwipeBloc()
              ..add(
                LoadUsers(
                  // users: User.users,
                  users: User.users.where((user) => user.id != 1).toList(),
                ),
              ),
          ),
        ],
        child: MaterialApp(
          title: 'Max Dating App',
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
