import 'dart:convert';

class ChatMessageData {

  bool isMe;
  int time;
  String content;

  ChatMessageData(this.isMe, this.time, this.content);

  String toJson() {
    return jsonEncode({
      'isMe': isMe,
      'time': time,
      'content': content
    });
  }

  static ChatMessageData fromJson(String json) {
    Map<String, dynamic> map = jsonDecode(json);
    return ChatMessageData(
      map['isMe'],
      map['time'],
      map['content']
    );
  }
}