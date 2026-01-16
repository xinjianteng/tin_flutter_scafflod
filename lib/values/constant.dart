/// 通用业务常量，便于统一维护。
class AppConstants {
  // 分页配置
  static const int pageSize = 20;
  static const int debounceMs = 300;
  static const Duration requestTimeout = Duration(seconds: 10);

  // 缓存键名
  static const String cacheUser = 'cache_user';
  static const String cacheToken = 'cache_token';
  static const String cacheTheme = 'cache_theme';

  // 默认资源占位
  static const String defaultAvatar = 'assets/images/avatar_default.png';
  static const String defaultCover = 'assets/images/cover_default.png';

  // 常用正则
  static final RegExp phoneReg = RegExp(r'^1[3-9]\d{9}$');
  static final RegExp emailReg =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

  // 存储加密（示例默认值，建议按业务替换）
  static const String aesKey = 'a1b2c3d4e5f6g7h8';
  static const String aesIv = 'h8g7f6e5d4c3b2a1';
}
