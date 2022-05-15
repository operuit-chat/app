import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:operuit_flutter/chat.dart';

class CurrentChatContext {
  static String name = "none";
}

class ListedChat extends StatelessWidget {
  String name, message;
  final int time;

  ListedChat(
      {Key? key, required this.name, required this.message, required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var date = DateTime.fromMillisecondsSinceEpoch(time);
    var timeFormatted = DateFormat("HH:mm").format(date);
    var dayFormatted = DateFormat("EEEE").format(date);
    var dateFormatted = DateFormat("yyyy-MM-dd").format(date);
    var currentTime = DateTime.now();
    return GestureDetector(
      onTap: () =>
          {openChat(context, name)},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.black,
                child: Text(name[0]),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                          decoration: TextDecoration.none)),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Text(
                      message,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Roboto',
                          fontSize: 16,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              currentTime.difference(date).inHours >= 24
                  ? currentTime.difference(date).inDays >= 7
                      ? dateFormatted
                      : dayFormatted
                  : timeFormatted,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
          ],
        ),
      ),
    );
  }

  openChat(BuildContext context, String name) {
    CurrentChatContext.name = name;
    Navigator.pushNamed(context, 'chat');
  }
}
