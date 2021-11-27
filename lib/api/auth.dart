import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  Future<String> readResponse(HttpClientResponse response) async {
    return response.transform(utf8.decoder).join();
  }

  Future<HttpClientResponse> _post(String path, String data) async {
    ByteData cert = await rootBundle.load("assets/rootCA.pfx");
    final client = HttpClient(context: SecurityContext(withTrustedRoots: true)
      ..useCertificateChainBytes(cert.buffer.asUint8List(), password: 'FLh4ZQaRQwdqhG6F')
      ..usePrivateKeyBytes(cert.buffer.asUint8List(), password: 'FLh4ZQaRQwdqhG6F'));
    final request = await client.postUrl(Uri.parse(_uri + path));
    _headers.forEach((key, value) => {request.headers.set(key, value)});
    request.add(utf8.encode(json.decode(data)));
    final response = await request.close();
    return response;
  }

  Future<HttpClientResponse> _get(String path, String dataStr) async {
    ByteData cert = await rootBundle.load("assets/rootCA.pfx");
    final client = HttpClient(context: SecurityContext(withTrustedRoots: true)
      ..useCertificateChainBytes(cert.buffer.asUint8List(), password: 'FLh4ZQaRQwdqhG6F')
      ..usePrivateKeyBytes(cert.buffer.asUint8List(), password: 'FLh4ZQaRQwdqhG6F'));
    final request = await client.getUrl(Uri.parse(_uri + path + "?" + dataStr));
    _headers.forEach((key, value) => {request.headers.set(key, value)});
    final response = await request.close();
    return response;
  }

  Future<int> register(
      String username, String displayName, String password) async {
    var value = await _post(
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
    var contents = await readResponse(value);
    var result = jsonDecode(contents);
    return result["code"];
  }

  Future<bool> login(String username, String password) async {
    var value = await _post('login',
        jsonEncode("{\"username\":\"$username\", \"password\":\"$password\"}"));
    if (value.statusCode != 200) {
      lastRequest = value.headers.value("cf-ray")!;
      showSimpleNotification(
          Text(
              "An unknown error occurred, please try again.\nCF-Ray: $lastRequest"),
          background: Colors.red,
          position: NotificationPosition.bottom);
    }
    var contents = await readResponse(value);
    var result = jsonDecode(contents);
    return result["code"] == 200;
  }

  Future<String> salt(String username) async {
    var value = await _get('salt', "username=$username");
    if (value.statusCode != 200) {
      lastRequest = value.headers.value("cf-ray")!;
      showSimpleNotification(
          Text(
              "An unknown error occurred, please try again.\nCF-Ray: $lastRequest"),
          background: Colors.red,
          position: NotificationPosition.bottom);
    }
    var contents = await readResponse(value);
    var result = jsonDecode(contents);
    return result["code"] == 200 ? result["message"] : "";
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
