import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import 'package:max_dating_app/models/models.dart';
import 'package:max_dating_app/repositories/repositories.dart';

class DatabaseRepository extends BaseDatabaseRepository {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<User> getUser(String userId) {
    return _firebaseFirestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snap) => User.fromSnapshot(snap));
  }

  @override
  Stream<Chat> getChat(String chatId) {
    return _firebaseFirestore.collection('chats').doc(chatId).snapshots().map(
          (doc) => Chat.fromJson(
            doc.data() as Map<String, dynamic>,
            id: doc.id,
          ),
        );
  }

  @override
  Stream<List<User>> getUsers(
    User user,
  ) {
    return _firebaseFirestore
        .collection('users')
        .where(
          'gender',
          whereIn: selectGender(user),
        )
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => User.fromSnapshot(doc)).toList();
    });
  }

  @override
  Stream<List<User>> getUsersToSwipe(
    User user,
  ) {
    return Rx.combineLatest2(
      getUser(user.id!),
      getUsers(user),
      (
        User currentUser,
        List<User> users,
      ) {
        // NOTE: running multiple times, Stream effect (?)
        // Runs UpdateUsers and/or LoadUsers (def Load)
        // Comes from SwipeBloc
        print('get users in get users to swipe');
        List<User> userList = users.where((user) {
          bool isCurrentUser = user.id == currentUser.id;
          bool wasSwipedLeft = currentUser.swipeLeft!.contains(user.id);
          bool wasSwipedRight = currentUser.swipeRight!.contains(user.id);
          bool isMatch = currentUser.matches!.contains(user.id);
          bool isWithinAgeRange =
              user.age >= currentUser.ageRangePreference![0] &&
                  user.age <= currentUser.ageRangePreference![1];
          bool isWithinDistance =
              getDistance(currentUser, user) <= currentUser.distancePreference;

          // print('user: ${user.name}');
          // print('isCurrentUser: $isCurrentUser');
          // print('wasSwipedRight: $wasSwipedRight');
          // print('wasSwipedLeft: $wasSwipedLeft');
          // print('isMatch: $isMatch');
          // print('isWithinAgeRange: $isWithinAgeRange');
          // print('isWithinDistance: $isWithinDistance');

          if (isCurrentUser) return false;
          if (wasSwipedRight) return false;
          if (wasSwipedLeft) return false;
          if (isMatch) return false;
          if (!isWithinAgeRange) return false;
          if (!isWithinDistance) return false;

          return true;
        }).toList();
        print('users: ${userList.length}');
        return userList;
      },
    );
  }

  @override
  Stream<List<Match>> getMatches(User user) {
    return Rx.combineLatest3(
      getUser(user.id!),
      getChats(user.id!),
      getUsers(user),
      (
        User user,
        List<Chat> userChats,
        List<User> otherUsers,
      ) {
        print('get matches for ${user.name}');
        return otherUsers.where(
          (otherUser) {
            List<String> matches = user.matches!
                .map((match) => match['matchId'] as String)
                .toList();

            return matches.contains(otherUser.id);
          },
        ).map(
          (matchUser) {
            Chat chat = userChats.where(
              (chat) {
                return chat.userIds.contains(matchUser.id) &
                    chat.userIds.contains(user.id);
              },
            ).first;

            return Match(
              userId: user.id!,
              matchUser: matchUser,
              chat: chat,
            );
          },
        ).toList();
      },
    );
  }

  @override
  Stream<List<Chat>> getChats(String userId) {
    return _firebaseFirestore
        .collection('chats')
        .where(
          'userIds',
          arrayContains: userId,
        )
        .snapshots()
        .map((snap) {
      return snap.docs
          .map((doc) => Chat.fromJson(
                // doc.data() as Map<String, dynamic>,
                doc.data(),
                id: doc.id,
              ))
          .toList();
    });
  }

  @override
  Future<void> updateUserPictures(
    User user,
    String imageName,
  ) async {
    String downloadUrl = await StorageRepository().getDownloadUrl(
      user,
      imageName,
    );

    return _firebaseFirestore.collection('users').doc(user.id).update({
      'imageUrls': FieldValue.arrayUnion([downloadUrl]),
    });
  }

  @override
  Future<User> getMatchedUser(User user) async {
    return _firebaseFirestore.collection('users').doc(user.id).get().then(
          (doc) => User.fromSnapshot(doc),
        );
  }

  @override
  Future<void> createUser(User user) async {
    await _firebaseFirestore.collection('users').doc(user.id).set(user.toMap());
  }

  @override
  Future<void> updateUser(User user) async {
    return _firebaseFirestore
        .collection('users')
        .doc(user.id)
        .update(user.toMap());
    // .then(
    //   (value) => (value) => print('User document updated.'),
    // );
  }

  @override
  Future<void> updateUserSwipe(
    String userId,
    String matchId,
    bool isSwipeRight,
  ) async {
    if (isSwipeRight) {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeRight': FieldValue.arrayUnion([matchId]),
      });
    } else {
      await _firebaseFirestore.collection('users').doc(userId).update({
        'swipeLeft': FieldValue.arrayUnion([matchId]),
      });
    }
  }

  @override
  Future<void> updateUserMatch(
    String userId,
    String matchId,
  ) async {
    // Create a document in the chat collection to store the messages
    String chatId = await _firebaseFirestore.collection('chats').add({
      'userIds': [
        userId,
        matchId,
      ],
      'messages': [],
    }).then((value) => value.id);

    // Add the match into the current user document
    await _firebaseFirestore.collection('users').doc(userId).update({
      'matches': FieldValue.arrayUnion([
        {
          'matchId': matchId,
          'chatId': chatId,
        }
      ]),
    });
    // Add the match in the other user document too
    await _firebaseFirestore.collection('users').doc(matchId).update({
      'matches': FieldValue.arrayUnion([
        {
          'matchId': userId,
          'chatId': chatId,
        }
      ]),
    });
  }

  @override
  Future<void> addMessage(
    String chatId,
    Message message,
  ) {
    return _firebaseFirestore.collection('chats').doc(chatId).update({
      'messages': FieldValue.arrayUnion([
        message.toJson(),
      ])
    });
  }

  getDistance(
    User currentUser,
    User user,
  ) {
    GeolocatorPlatform geolocator = GeolocatorPlatform.instance;
    var distanceInKm = geolocator.distanceBetween(
          currentUser.location!.lat.toDouble(),
          currentUser.location!.lon.toDouble(),
          user.location!.lat.toDouble(),
          user.location!.lon.toDouble(),
        ) ~/
        1000;
    return distanceInKm;
  }

  selectGender(User user) {
    if (user.genderPreference!.isEmpty) {
      return ['Male', 'Female'];
    }
    return user.genderPreference;
  }
}
