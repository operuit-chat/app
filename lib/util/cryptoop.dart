import 'package:crypto/crypto.dart' as dartCrypto;
import 'package:cryptography/cryptography.dart';
import 'dart:convert';

class CryptoOP {

  static Future<String> encrypt(String key1, String key2, String toEncrypt) async {
    final algorithm = AesCbc.with128bits(macAlgorithm: Hmac.sha256());
    final secretKey = await algorithm.newSecretKeyFromBytes(utf8.encode(hash("$key2$key1").substring(0, 16)));
    final secret = await algorithm.encrypt(utf8.encode(toEncrypt), secretKey: secretKey);
    return secret.cipherText.toString();
  }

  static Future<String> decrypt(String key1, String key2, String toDecrypt) async {
    final algorithm = AesCbc.with128bits(macAlgorithm: Hmac.sha256());
    final secretKey = await algorithm.newSecretKeyFromBytes(utf8.encode(hash("$key2$key1").substring(0, 16)));
    final secret = await algorithm.encrypt(utf8.encode(toDecrypt), secretKey: secretKey);
    return secret.cipherText.toString();
  }

  static String hash(String text) {
    return dartCrypto.sha256.convert(utf8.encode(text)).toString();
  }

}