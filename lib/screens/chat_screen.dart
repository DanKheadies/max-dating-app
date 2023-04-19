import 'package:flutter/material.dart';

import 'package:max_dating_app/models/models.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/chat';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const ChatScreen(
          // userMatch: userMatch,
          ),
    );
  }

  // final Match userMatch;

  const ChatScreen({
    super.key,
    // required this.userMatch,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Column(
          children: [
            // CircleAvatar(
            //   radius: 15,
            //   backgroundImage: NetworkImage(userMatch.matchedUser.imageUrls[0]),
            // ),
            // Text(
            //   userMatch.matchedUser.name,
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // SingleChildScrollView(
          //   child: userMatch.chat != null
          //       ? SizedBox(
          //           child: ListView.builder(
          //               shrinkWrap: true,
          //               itemCount: userMatch.chat![0].messages.length,
          //               itemBuilder: (context, index) {
          //                 return ListTile(
          //                   title: userMatch
          //                               .chat![0].messages[index].senderId ==
          //                           1
          //                       ? Align(
          //                           alignment: Alignment.topRight,
          //                           child: Container(
          //                             padding: const EdgeInsets.all(8),
          //                             decoration: BoxDecoration(
          //                               borderRadius: const BorderRadius.all(
          //                                 Radius.circular(8),
          //                               ),
          //                               color: Theme.of(context)
          //                                   .colorScheme
          //                                   .primary,
          //                             ),
          //                             child: Text(
          //                               userMatch
          //                                   .chat![0].messages[index].message,
          //                               style: Theme.of(context)
          //                                   .textTheme
          //                                   .titleLarge!
          //                                   .copyWith(
          //                                     color: Colors.white,
          //                                   ),
          //                             ),
          //                           ),
          //                         )
          //                       : Align(
          //                           alignment: Alignment.topLeft,
          //                           child: Row(
          //                             children: [
          //                               CircleAvatar(
          //                                 radius: 15,
          //                                 backgroundImage: NetworkImage(
          //                                   userMatch.matchedUser.imageUrls[0],
          //                                 ),
          //                               ),
          //                               const SizedBox(width: 10),
          //                               Container(
          //                                 padding: const EdgeInsets.all(8),
          //                                 decoration: BoxDecoration(
          //                                   borderRadius:
          //                                       const BorderRadius.all(
          //                                     Radius.circular(8),
          //                                   ),
          //                                   color: Theme.of(context)
          //                                       .colorScheme
          //                                       .background,
          //                                 ),
          //                                 child: Text(
          //                                   userMatch.chat![0].messages[index]
          //                                       .message,
          //                                   style: Theme.of(context)
          //                                       .textTheme
          //                                       .titleLarge,
          //                                 ),
          //                               ),
          //                             ],
          //                           ),
          //                         ),
          //                 );
          //               }),
          //         )
          //       : const SizedBox(),
          // ),
          // Container(
          //   padding: const EdgeInsets.only(
          //     bottom: 35,
          //     top: 5,
          //     left: 20,
          //     right: 35,
          //   ),
          //   child: Row(
          //     children: [
          //       Container(
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //         child: IconButton(
          //           icon: const Icon(Icons.send_outlined),
          //           color: Colors.white,
          //           onPressed: () {},
          //         ),
          //       ),
          //       const Expanded(
          //         child: TextField(
          //           decoration: InputDecoration(
          //             fillColor: Colors.white,
          //             filled: true,
          //             hintText: 'Type here...',
          //             contentPadding: EdgeInsets.only(
          //               left: 20,
          //               bottom: 5,
          //               top: 5,
          //             ),
          //             focusedBorder: OutlineInputBorder(
          //               borderSide: BorderSide(
          //                 color: Colors.white,
          //               ),
          //             ),
          //             enabledBorder: UnderlineInputBorder(
          //               borderSide: BorderSide(
          //                 color: Colors.white,
          //               ),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
