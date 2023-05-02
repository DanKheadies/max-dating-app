import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:max_dating_app/models/models.dart';

class Match extends Equatable {
  final String userId;
  final User matchUser;
  final Chat chat;

  const Match({
    required this.userId,
    required this.matchUser,
    required this.chat,
  });

  // static Match fromSnapshot(
  //   DocumentSnapshot snap,
  //   String userId,
  // ) {
  //   Match match = Match(
  //     userId: userId,
  //     matchedUser: User.fromSnapshot(snap),
  //   );
  //   return match;
  // }

  Match copyWith({
    String? userId,
    User? matchUser,
    Chat? chat,
  }) {
    return Match(
      userId: userId ?? this.userId,
      matchUser: matchUser ?? this.matchUser,
      chat: chat ?? this.chat,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        matchUser,
        chat,
      ];

  // static List<Match> matches = [
  //   Match(
  //     userId: '1',
  //     matchedUser: User.users[1],
  //     chat: Chat.chats
  //         .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
  //         .toList(),
  //   ),
  //   Match(
  //     userId: '1',
  //     matchedUser: User.users[1],
  //     chat: Chat.chats
  //         .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
  //         .toList(),
  //   ),
  //   Match(
  //     userId: '1',
  //     matchedUser: User.users[1],
  //     chat: Chat.chats
  //         .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
  //         .toList(),
  //   ),
  //   Match(
  //     userId: '1',
  //     matchedUser: User.users[1],
  //     chat: Chat.chats
  //         .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
  //         .toList(),
  //   ),
  //   Match(
  //     userId: '1',
  //     matchedUser: User.users[1],
  //     chat: Chat.chats
  //         .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
  //         .toList(),
  //   ),
  //   Match(
  //     userId: '1',
  //     matchedUser: User.users[1],
  //     chat: Chat.chats
  //         .where((chat) => chat.userId == 1 && chat.matchedUserId == 2)
  //         .toList(),
  //   ),
  // ];
}
