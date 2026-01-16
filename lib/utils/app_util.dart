import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// 工具类，提供应用程序相关的实用功能。
class AppUtil {


  static bool isMobile() {
    final isMobile = !kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS||
            defaultTargetPlatform == TargetPlatform.ohos
        );
    return isMobile;
  }

  /// 获取当前时间的毫秒级时间戳。
  ///
  /// [time] 可选参数，指定的时间，若不提供则使用当前时间。
  ///
  /// 返回指定时间的时间戳。
  ///
  /// 获取时间戳，不传值代表获取当前时间戳。
  static String getTime([DateTime? time]) {
    return (time ?? DateTime.now()).millisecondsSinceEpoch.toString();
  }

  /// 生成一个随机的nonce字符串。
  ///
  /// 随机字符串用于安全相关的操作，如防止请求重复等。
  static const String nonceSet =
      "0123456789abcdefghijklmnoprrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

  /// 生成一个16字符长度的随机nonce字符串。
  ///
  /// 返回生成的随机字符串。
  static String getNonce() {
    final length = nonceSet.length;
    final buffer = StringBuffer();
    final random = Random();
    for (var i = 0; i < 16; i++) {
      buffer.write(nonceSet[random.nextInt(length)]);
    }
    return buffer.toString();
  }

  /// 在外部浏览器中打开指定URL。
  ///
  /// [url] 要打开的URL地址。
  ///
  /// 返回Future<void>，表示异步操作完成。
  ///
  /// 如果无法启动URL，则抛出异常。
  static Future<void> openInBrowser(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication, // 强制使用浏览器
    )) {
      throw 'Could not launch $url';
    }
  }
}
