import 'package:flutter/foundation.dart';

/// 统一的跨端检测工具，避免直接引用 dart:io 导致 Web 构建报错。
class PlatformUtil {
  static bool get isWeb => kIsWeb;

  static bool get isMobile =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);

  static bool get isDesktop =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.linux);

  static String get label {
    if (isWeb) return 'Web';
    if (isMobile) return '移动端';
    if (isDesktop) return '桌面端';
    return '未知端';
  }

  /// 权限、原生硬件等插件只在移动/桌面可用。
  static bool get supportsNativePlugins => isMobile || isDesktop;

  /// sqflite 等本地数据库插件仅支持移动/桌面。
  static bool get supportsLocalDb => isMobile || isDesktop;
}
