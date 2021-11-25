import 'dart:math';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:operuit_flutter/util/cryptoop.dart';

class Auth {
  static final _initTime = DateTime.now().millisecondsSinceEpoch;

  static const _uri = "https://operuit.shortydev.eu:2053/";
  static final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "User-TempDevId": CryptoOP.hash("$_initTime").substring(0, 6),
  };

  static Future<http.Response> _post(String path, String data) {
    return http.post(Uri.parse(_uri + path),
        body: json.decode(data), headers: _headers);
  }

  static Future<int> register(
      String username, String displayName, String password) {
    _post(
            'register',
            jsonEncode(
                "{\"username\":\"$username\", \"displayName\":\"$displayName\", \"password\":\"$password\"}"))
        .then((value) => {print(value.body)});
    return Future.value(0);
  }

  static String getRandom(int length) {
    const ch = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz0123456789';
    Random r = Random();
    return String.fromCharCodes(
        Iterable.generate(length, (_) => ch.codeUnitAt(r.nextInt(ch.length))));
  }
}
