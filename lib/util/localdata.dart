import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalData {

  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/auth');
  }

  static Future<File> writeUserdata(String data) async {
    final file = await _localFile;
    if (await fileExists()) {
      await file.delete();
    }
    return file.writeAsString(data);
  }

  static Future<String> readUserdata() async {
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return "";
    }
  }

  static Future<bool> fileExists() async {
    final file = await _localFile;
    return file.exists();
  }

}