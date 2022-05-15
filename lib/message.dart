import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String message;

  const Message({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var fromMe = message.startsWith('<');
    return Container(
      margin: EdgeInsets.only(left: fromMe ? 64 : 12, right: fromMe ? 64 : 12, top: 8, bottom: 8),
      padding: const EdgeInsets.only(left: 12, right: 12, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(25, 25, 25, double.parse(fromMe ? '0.5' : '1.0')),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        message.substring(1),
        textAlign: fromMe ? TextAlign.right : TextAlign.left,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
