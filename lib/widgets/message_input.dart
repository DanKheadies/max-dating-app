import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:max_dating_app/blocs/blocs.dart';
import 'package:max_dating_app/models/models.dart';

class MessageInput extends StatelessWidget {
  const MessageInput({
    super.key,
    required this.match,
  });

  final Match match;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: IconButton(
              icon: const Icon(Icons.send_outlined),
              color: Colors.white,
              onPressed: () {
                context.read<ChatBloc>().add(
                      AddMessage(
                        userId: match.userId,
                        matchUserId: match.matchUser.id!,
                        message: controller.text,
                      ),
                    );
                controller.clear();
              },
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true,
                hintText: 'Type here...',
                contentPadding: EdgeInsets.only(
                  left: 20,
                  bottom: 5,
                  top: 5,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
