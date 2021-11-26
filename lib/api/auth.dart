import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:operuit_flutter/util/cryptoop.dart';
import 'package:overlay_support/overlay_support.dart';

class Auth extends StatelessWidget {
  static String lastRequest = "";

  static final _initTime = DateTime.now().millisecondsSinceEpoch;
  static const _uri = "https://operuit.shortydev.eu:2053/";
  static final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "User-TempDevId": CryptoOP.hash("$_initTime").substring(0, 6),
  };

  static String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }

  const Auth({Key? key}) : super(key: key);

  Future<http.Response> _post(String path, String data) {
    return http.post(Uri.parse(_uri + path),
        body: json.decode(data), headers: _headers);
  }

  Future<http.Response> _get(String path, String dataStr) {
    return http.get(Uri.parse(_uri + path + "?" + dataStr),
        headers: _headers);
  }

  Future<int> register(String username, String displayName, String password) async {
    var value = await _post(
            'register',
            jsonEncode(
                "{\"username\":\"$username\", \"displayName\":\"$displayName\", \"password\":\"$password\"}"));
    if (value.statusCode != 200) {
      lastRequest = value.headers.entries.where((element) => element.key.toLowerCase() == "cf-ray").first.value;
      showSimpleNotification(
          Text(
              "An unknown error occurred, please try again.\nCF-Ray: $lastRequest"),
          background: Colors.red,
          position:
          NotificationPosition.bottom);
    }
    var result = jsonDecode(value.body);
    return result["code"];
  }

  Future<bool> login(String username, String password) async {
    var value = await _post(
        'login',
        jsonEncode(
            "{\"username\":\"$username\", \"password\":\"$password\"}"));
    if (value.statusCode != 200) {
      lastRequest = value.headers.entries.where((element) => element.key.toLowerCase() == "cf-ray").first.value;
      showSimpleNotification(
          Text(
              "An unknown error occurred, please try again.\nCF-Ray: $lastRequest"),
          background: Colors.red,
          position:
          NotificationPosition.bottom);
    }
    var result = jsonDecode(value.body);
    return result["code"] == 200;
  }

  Future<String> salt(String username) async {
    var value = await _get(
        'salt',
            "username=$username");
    if (value.statusCode != 200) {
      lastRequest = value.headers.entries.where((element) => element.key.toLowerCase() == "cf-ray").first.value;
      showSimpleNotification(
          Text(
              "An unknown error occurred, please try again.\nCF-Ray: $lastRequest"),
          background: Colors.red,
          position:
          NotificationPosition.bottom);
    }
    var result = jsonDecode(value.body);
    return result["code"] == 200 ? result["message"] : "";
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
