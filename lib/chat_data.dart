import 'package:operuit_flutter/chat_message_data.dart';

class ChatData {

  String username;
  String encryption;
  List<ChatMessageData> messages;

  ChatData(this.username, this.encryption, this.messages);
}