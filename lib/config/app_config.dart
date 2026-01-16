import 'package:flutter/foundation.dart';
import 'env_config.dart';

/// 应用配置类
class AppConfig {
  /// 应用名称
  static const String appName = 'Tin Flutter 脚手架';

  /// 应用版本
  static const String appVersion = '1.0.0';

  /// 应用包名
  static const String packageName = 'com.example.tin_flutter_scafflod';

  /// 是否为 Release 模式
  static bool get isRelease => kReleaseMode;

  /// 是否为 Debug 模式
  static bool get isDebug => kDebugMode;

  /// API 超时时间（毫秒）
  static const int apiTimeout = 30000;

  /// 分页大小
  static const int pageSize = 20;

  /// 图片缓存大小（MB）
  static const int imageCacheSize = 100;

  /// 是否启用性能监控
  static bool get enablePerformanceMonitor => EnvConfig.isDev;

  /// 是否显示环境标识
  static bool get showEnvBadge => !EnvConfig.isProd;

  /// 获取完整的应用信息
  static String get appInfo =>
      '$appName v$appVersion (${EnvConfig.envName})';
}
