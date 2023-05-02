import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({
    required Match match,
  }) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => ChatScreen(
        match: match,
      ),
    );
  }

  final Match match;

  const ChatScreen({
    super.key,
    required this.match,
  });

  @override
  Widget build(BuildContext context) {
    var messageCount = match.chat.messages.length;

    return Scaffold(
      appBar: MessageAppBar(
        match: match,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: match.chat.messages.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: MessageBubble(
                  message: match.chat.messages[index].message,
                  isFromCurrentUser: match.chat.messages[index].senderId ==
                      context.read<AuthBloc>().state.authUser!.uid,
                ),
              );
            },
          ),
          const Spacer(),
          MessageInput(
            match: match,
          ),
        ],
      ),
    );
  }
}
