import 'package:crypto/crypto.dart' as dart_crypto;
import 'package:steel_crypt/steel_crypt.dart';
import 'dart:convert';

class CryptoOP {
  static Future<String> encrypt(
      String key1, String key2, String toEncrypt) async {
    var aes = AesCrypt(key: hash(key1 + key2).substring(0, 32), padding: PaddingAES.pkcs7);
    var encrypted = aes.gcm.encrypt(inp: toEncrypt, iv: "0000000000000000");
    return encrypted;
  }

  static Future<String> decrypt(
      String key1, String key2, String toDecrypt) async {
    var aes = AesCrypt(key: hash(key1 + key2).substring(0, 32), padding: PaddingAES.pkcs7);
    var decrypted = aes.gcm.decrypt(enc: toDecrypt, iv: "0000000000000000");
    return decrypted;
  }

  static String hash(String text) {
    return dart_crypto.sha256.convert(utf8.encode(text)).toString();
  }
}
