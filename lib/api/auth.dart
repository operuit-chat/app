import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class Auth {

  static var initTime = DateTime.now().millisecondsSinceEpoch;

  var uri = "https://operuit.shortydev.eu:2053/";
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "User-TempDevId": sha256.convert(utf8.encode("$initTime")).toString().substring(0, 6),
  };

  Future<http.Response> _post(String path, String data) {
    return http.post(Uri.parse(uri + path), body: json.decode(data), headers: headers);
  }

  Future<int> register(String username, String displayName, String password) {
    _post('register',
        "{\"username\":\"$username\", \"displayName\":\"$displayName\", \"password\":\"$password\"}").then((value) => {
          print(value.body)
    });
    return Future.value(null);
  }
}
