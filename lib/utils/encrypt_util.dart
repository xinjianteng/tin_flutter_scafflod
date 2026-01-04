import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

/// 加密工具类：提供常用的 MD5 和 AES 示例实现。
class EncryptUtils {
  /// MD5 加密，返回大写十六进制字符串。
  static String encryptMd5(String str) {
    final utf = utf8.encode(str);
    final digest = md5.convert(utf);
    final encryptStr = digest.toString();
    return encryptStr.toUpperCase();
  }

  /// AES CBC 加密，返回 base64 编码。
  static String encryptAES(String content, String keyStr, String ivStr) {
    final key = encrypt.Key.fromUtf8(keyStr);
    final iv = encrypt.IV.fromUtf8(ivStr);
    final encrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    final encrypted = encrypter.encrypt(content, iv: iv);
    return encrypted.base64;
  }

  /// AES CBC 解密，返回明文。
  static String decryptAES(String content, String keyStr, String ivStr) {
    final encrypted = encrypt.Encrypted.fromBase64(content);
    final key = encrypt.Key.fromUtf8(keyStr);
    final iv = encrypt.IV.fromUtf8(ivStr);
    final decrypter =
        encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));
    return decrypter.decrypt(encrypted, iv: iv);
  }
}
