import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/screens/screens.dart';
// import 'package:max_dating_app/repositories/repositories.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final bool hasActions;
  final bool isLogin;
  final bool isSignUp;
  final List<IconData> actionsIcons;
  final List<String> actionsRoutes;

  const CustomAppBar({
    super.key,
    required this.title,
    this.hasActions = true,
    this.isLogin = false,
    this.isSignUp = false,
    this.actionsIcons = const [
      Icons.message,
      Icons.person,
    ],
    this.actionsRoutes = const [
      MatchesScreen.routeName,
      ProfileScreen.routeName,
    ],
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                title == 'DISCOVER' || isLogin
                    ? () {}
                    : isSignUp
                        ? Navigator.of(context).pop()
                        : Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                            (route) => false,
                          );
              },
              enableFeedback: title == 'DISCOVER' ? false : true,
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
                  actionsIcons[0],
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(actionsRoutes[0]);
                },
              ),
              IconButton(
                icon: Icon(
                  actionsIcons[1],
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(actionsRoutes[1]);
                },
              ),
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
