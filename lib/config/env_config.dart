/// 环境类型枚举
enum Environment {
  dev,
  test,
  prod,
}

/// 环境配置类
class EnvConfig {
  static Environment _currentEnv = Environment.dev;

  /// 获取当前环境
  static Environment get currentEnv => _currentEnv;

  /// 设置当前环境
  static void setEnvironment(Environment env) {
    _currentEnv = env;
  }

  /// 是否为开发环境
  static bool get isDev => _currentEnv == Environment.dev;

  /// 是否为测试环境
  static bool get isTest => _currentEnv == Environment.test;

  /// 是否为生产环境
  static bool get isProd => _currentEnv == Environment.prod;

  /// 获取 API 基础地址
  static String get apiBaseUrl {
    switch (_currentEnv) {
      case Environment.dev:
        return 'https://dev-api.example.com';
      case Environment.test:
        return 'https://test-api.example.com';
      case Environment.prod:
        return 'https://api.example.com';
    }
  }

  /// 获取环境名称
  static String get envName {
    switch (_currentEnv) {
      case Environment.dev:
        return '开发环境';
      case Environment.test:
        return '测试环境';
      case Environment.prod:
        return '生产环境';
    }
  }

  /// 是否启用日志
  static bool get enableLog => !isProd;

  /// 是否启用调试工具
  static bool get enableDebugTools => isDev;
}
