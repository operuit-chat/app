import 'package:flutter/material.dart';
import 'package:operuit_flutter/chatbar.dart';
import 'package:operuit_flutter/contact_chat.dart';
import 'package:operuit_flutter/message.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  List<String> messages =
      List.of([">Hello", "<How are you?", ">I'm fine", "<What's up?", ">Nothing", "<Where are you?", ">I'm in the office",
      ">And you?", "<I'm at school."]);

  List<Message> _buildMessages() {
    return messages.map((message) => Message(message: message)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 25,
        title: Row(children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black,
              child: Text(CurrentChatContext.name[0]),
            ),
          ),
          Text(CurrentChatContext.name)
        ]),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        backgroundColor: const Color.fromRGBO(52, 60, 74, 1),
      ),
      backgroundColor: const Color.fromRGBO(52, 60, 74, 100),
      body: Container(
        child: ListView(
          children: _buildMessages(),
        ),
      ),
      bottomSheet: const ChatBar(),
    );
  }
}
