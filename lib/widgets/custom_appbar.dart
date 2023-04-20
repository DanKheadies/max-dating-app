import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/screens/screens.dart';
import 'package:max_dating_app/repositories/repositories.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.hasActions = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                title == 'PROFILE'
                    ? () {}
                    : Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/home',
                        (route) => false,
                      );
              },
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                height: 50,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
      actions: hasActions
          ? [
              IconButton(
                icon: Icon(
                  Icons.message,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(MatchesScreen.routeName);
                },
              ),
              IconButton(
                icon: Icon(
                  title == 'PROFILE' ? Icons.person_outline : Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                enableFeedback: title == 'PROFILE' ? false : true,
                onPressed: () {
                  title == 'PROFILE'
                      ? () {}
                      : Navigator.of(context)
                          .pushNamed(ProfileScreen.routeName);

                  // RepositoryProvider.of<AuthRepository>(context).signOut();
                },
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
