import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';
import 'package:max_dating_app/widgets/widgets.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route({
    required Match match,
  }) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => BlocProvider(
        create: (context) => ChatBloc(
          databaseRepository: context.read<DatabaseRepository>(),
        )..add(
            LoadChat(match.chat.id),
          ),
        child: ChatScreen(
          match: match,
        ),
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
    return Scaffold(
      appBar: MessageAppBar(
        match: match,
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ChatLoaded) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: state.chat.messages.length,
                  itemBuilder: (context, index) {
                    List<Message> messages = state.chat.messages;

                    return ListTile(
                      title: MessageBubble(
                        message: messages[index].message,
                        isFromCurrentUser: messages[index].senderId ==
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
            );
          } else {
            return const Center(
              child: Text('Something went wrong.'),
            );
          }
        },
      ),
    );
  }
}
