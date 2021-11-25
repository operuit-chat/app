import 'package:flutter/material.dart';

class MessageNotification extends StatelessWidget {
  final VoidCallback onClick;
  final String title;
  final String message;
  final IconData icon;

  const MessageNotification(
      {Key? key,
      required this.onClick,
      required this.title,
      required this.message,
      required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: SafeArea(
          child: ListTile(
            title: Text(title),
            subtitle: Text(message),
            trailing: IconButton(
                icon: Icon(icon),
                onPressed: () {
                  onClick();
                }),
          ),
        ),
      ),
    );
  }
}
