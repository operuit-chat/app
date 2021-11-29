import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:operuit_flutter/util/cryptoop.dart';

class HTTPClient {

  static final _initTime = DateTime.now().millisecondsSinceEpoch;
  static const _uri = "https://operuit.shortydev.eu:2053/";
  static final Map<String, String> _headers = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "User-TempDevId": CryptoOP.hash("$_initTime").substring(0, 6),
  };

  Future<String> readResponse(HttpClientResponse response) async {
    return response.transform(utf8.decoder).join();
  }

  Future<HttpClientResponse> post(String path, String data) async {
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

  Future<HttpClientResponse> get(String path, String dataStr) async {
    ByteData cert = await rootBundle.load("assets/rootCA.pfx");
    final client = HttpClient(context: SecurityContext(withTrustedRoots: true)
      ..useCertificateChainBytes(cert.buffer.asUint8List(), password: 'FLh4ZQaRQwdqhG6F')
      ..usePrivateKeyBytes(cert.buffer.asUint8List(), password: 'FLh4ZQaRQwdqhG6F'));
    final request = await client.getUrl(Uri.parse(_uri + path + "?" + dataStr));
    _headers.forEach((key, value) => {request.headers.set(key, value)});
    final response = await request.close();
    return response;
  }

}