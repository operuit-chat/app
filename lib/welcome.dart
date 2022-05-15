import 'package:flutter/material.dart';
import 'package:operuit_flutter/contact_chat.dart';
import 'package:operuit_flutter/login.dart';
import 'package:operuit_flutter/pin.dart';

import 'navdrawer.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List chats = [
    {
      "name": "Tizian",
      "message": "Du bisch so an trottel",
      "time": DateTime.parse("2022-03-07 09:53:00").millisecondsSinceEpoch,
    },
    {
      "name": "Lindner",
      "message": "Du opfer",
      "time": DateTime.parse("2022-03-07 04:20:00").millisecondsSinceEpoch,
    },
    {
      "name": "Natter",
      "message":
          "20 neue Aufgaben hinzugefügt",
      "time": DateTime.parse("2022-03-05 16:32:00").millisecondsSinceEpoch,
    },
    {
      "name": "Soster",
      "message": "Test 132",
      "time": DateTime.parse("2021-05-02 12:21:00").millisecondsSinceEpoch,
    }
  ];

  List<ListedChat> getChatsByTimeDesc() {
    var contactChats = <ListedChat>[];
    chats.sort((a, b) => b["time"].compareTo(a["time"]));
    for (var chat in chats) {
      contactChats.add(ListedChat(
        name: chat["name"],
        message: chat["message"],
        time: chat["time"],
      ));
    }
    return contactChats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyPin.loggedInName),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color.fromRGBO(52, 60, 74, 1),
      ),
      drawer: const NavDrawer(),
      backgroundColor: const Color.fromRGBO(52, 60, 74, 100),
      body: Container(
        padding: const EdgeInsets.only(top: 20),
        child: ListView(
          children: getChatsByTimeDesc(),
        ),
      ),
    );
  }
}