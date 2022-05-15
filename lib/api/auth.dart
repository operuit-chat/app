import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:operuit_flutter/api/http.dart';
import 'package:overlay_support/overlay_support.dart';

class Auth extends StatelessWidget {
  static String lastRequest = "";

  static String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  const Auth({Key? key}) : super(key: key);

  Future<int> register(
      String username, String displayName, String password) async {
    var value = await HTTPClient().post(
        'register',
        jsonEncode(
            "{\"username\":\"$username\", \"displayName\":\"$displayName\", \"password\":\"$password\"}"));
    if (value.statusCode != 200) {
      lastRequest = value.headers.value("cf-ray")!;
      showSimpleNotification(
          Text(
              "An unknown error occurred, please try again.\nCF-Ray: $lastRequest"),
          background: Colors.red,
          position: NotificationPosition.bottom);
    }
    var contents = await HTTPClient().readResponse(value);
    var result = jsonDecode(contents);
    return result["responseCode"];
  }

  Future<bool> login(String username, String password) async {
    var value = await HTTPClient().post('login',
        jsonEncode("{\"username\":\"$username\", \"password\":\"$password\"}"));
    if (value.statusCode != 200) {
      lastRequest = value.headers.value("cf-ray")!;
      showSimpleNotification(
          Text(
              "An unknown error occurred, please try again.\nCF-Ray: $lastRequest"),
          background: Colors.red,
          position: NotificationPosition.bottom);
    }
    var contents = await HTTPClient().readResponse(value);
    if (contents.startsWith("<")) {
      return false;
    }
    var result = jsonDecode(contents);
    return result["responseCode"] == 200;
  }

  Future<String> salt(String username) async {
    var value = await HTTPClient().get('salt', "username=$username");
    if (value.statusCode != 200) {
      lastRequest = value.headers.value("cf-ray")!;
      showSimpleNotification(
          Text(
              "An unknown error occurred, please try again.\nCF-Ray: $lastRequest"),
          background: Colors.red,
          position: NotificationPosition.bottom);
    }
    var contents = await HTTPClient().readResponse(value);
    var result = jsonDecode(contents);
    return result["responseCode"] == 200 ? result["message"] : "";
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
