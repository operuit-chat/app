import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:operuit_flutter/chat_message_data.dart';
import 'package:path_provider/path_provider.dart';

class LocalData {

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localAuthFile async {
    final path = await _localPath;
    return File('$path/auth');
  }

  static void deleteAuth() async {
    final file = await _localAuthFile;
    file.delete();
  }

  static Future<File> newChat(String chatId) async {
    final path = await _localPath;
    File file = File('$path/messages/$chatId');
    file.create(recursive: true);
    List<ChatMessageData> data = [];
    return file.writeAsString(jsonEncode(data));
  }

  static Future<File> saveMessages(String chatId, List<ChatMessageData> data) async {
    final path = await _localPath;
    File file = File('$path/messages/$chatId');
    return file.writeAsString(jsonEncode(data));
  }

  static Future<List<ChatMessageData>> loadChat(String chatId) async {
    final path = await _localPath;
    File file = File('$path/messages/$chatId');
    if (!file.existsSync()) {
      return Future.value([]);
    } else {
      return file.readAsString().then((String contents) {
        return jsonDecode(contents).map<ChatMessageData>((dynamic item) {
          return ChatMessageData.fromJson(item);
        }).toList();
      });
    }
  }

  static Future<List<String>> listChats() async {
    final path = await _localPath;
    Directory dir = Directory('$path/messages');
    if (!dir.existsSync()) {
      return Future.value([]);
    } else {
      return dir.list().map((FileSystemEntity entity) {
        return entity.path.split('/').last;
      }).toList();
    }
  }

  static Future<File> writeUserdata(String data) async {
    final file = await _localAuthFile;
    if (await fileExists()) {
      await file.delete();
    }
    return file.writeAsString(data);
  }

  static Future<String> readUserdata() async {
    try {
      final file = await _localAuthFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  static Future<bool> fileExists() async {
    final file = await _localAuthFile;
    return file.exists();
  }

}