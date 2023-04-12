import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      // automaticallyImplyLeading: false,
      actions: hasActions
          ? [
              IconButton(
                icon: Icon(
                  Icons.message,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  title == 'PROFILE' ? Icons.person_outline : Icons.person,
                  // Icons.person,
                  color: Theme.of(context).primaryColor,
                ),
                enableFeedback: title == 'PROFILE' ? false : true,
                onPressed: () {
                  title == 'PROFILE'
                      ? () {}
                      : Navigator.pushNamed(
                          context,
                          '/profile',
                        );
                },
              ),
            ]
          : [],
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       Icons.person_outline,
      //       color: Theme.of(context).primaryColor,
      //     ),
      //     onPressed: () {},
      //   ),
      // ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
