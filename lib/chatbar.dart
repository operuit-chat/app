import 'package:flutter/material.dart';

class ChatBar extends StatelessWidget {
  const ChatBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[900],
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          const Flexible(
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                hintText: 'Type your message here...',
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
