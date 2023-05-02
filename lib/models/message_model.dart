// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class Message extends Equatable {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime dateTime;
  final String timeString;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
    required this.timeString,
  });

  factory Message.fromJson(Map<String, dynamic> json, {String? id}) {
    // print('message from Json');
    // print(json['dateTime']);
    // print(json['dateTime'].toDate());
    // print(DateFormat().parse(json['dateTime']));
    // print(DateTime.parse(json['dateTime'].toDate().toString()));
    // print(DateFormat('yyyy-MM-dd hh:mm:ss')
    //     .parse(json['dateTime'].toDate().toString()));

    return Message(
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      message: json['message'],
      dateTime: json['dateTime'].toDate(),
      timeString: DateFormat('HH:mm').format(
        json['dateTime'].toDate(),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'dateTime': dateTime,
    };
  }

  // TODO: ? needed when everything is required (?)
  @override
  List<Object> get props => [
        senderId,
        receiverId,
        message,
        dateTime,
        timeString,
      ];

  static List<Message> messages = [
    Message(
      senderId: '1',
      receiverId: '2',
      message: 'Hey, how are you?',
      dateTime: DateTime.now(),
      timeString: DateFormat('jm').format(
        DateTime.now(),
      ),
    ),
    // Message(
    //     id: 2,
    //     senderId: 2,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 3,
    //     senderId: 1,
    //     receiverId: 2,
    //     message: 'I\'m good, as well. Thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 4,
    //     senderId: 1,
    //     receiverId: 3,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 5,
    //     senderId: 3,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 6,
    //     senderId: 1,
    //     receiverId: 5,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 7,
    //     senderId: 5,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 8,
    //     senderId: 1,
    //     receiverId: 6,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 9,
    //     senderId: 6,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 10,
    //     senderId: 1,
    //     receiverId: 7,
    //     message: 'Hey, how are you?',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
    // Message(
    //     id: 11,
    //     senderId: 7,
    //     receiverId: 1,
    //     message: 'I\'m good, thank you.',
    //     dateTime: DateTime.now(),
    //     timeString: DateFormat('jm').format(DateTime.now())),
  ];
}
