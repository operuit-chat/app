import 'dart:async';
import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:operuit_flutter/util/cryptoop.dart';

class Auth extends StatelessWidget {
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

  Future<int> register(String username, String displayName, String password) {
    var completer = Completer<int>();
    _post(
            'register',
            jsonEncode(
                "{\"username\":\"$username\", \"displayName\":\"$displayName\", \"password\":\"$password\"}"))
        .then((value) => {completer.complete(jsonDecode(value.body)["code"])});
    return completer.future;
  }

  Future<bool> login(String username, String password) async {
    var completer = Completer<bool>();
    var value = await _post(
        'login',
        jsonEncode(
            "{\"username\":\"$username\", \"password\":\"$password\"}"));
    var result = jsonDecode(value.body);
    completer.complete(result["code"] == 200);
    return completer.future;
  }

  Future<String> salt(String username) async {
    var completer = Completer<String>();
    var value = await _get(
        'salt',
            "username=$username");
    var result = jsonDecode(value.body);
    if (result["code"] == 200) {
      completer.complete(result["message"]);
    } else {
      completer.complete("");
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
