# 快速开始指南

## 环境要求

- Flutter SDK: ^3.6.2
- Dart SDK: ^3.6.2
- IDE: VS Code / Android Studio / IntelliJ IDEA

## 安装步骤

### 1. 克隆项目

```bash
git clone <repository-url>
cd tin_flutter_scafflod
```

### 2. 安装依赖

```bash
flutter pub get
```

### 3. 运行项目

```bash
# 开发环境
flutter run

# 指定设备
flutter run -d <device-id>

# 查看可用设备
flutter devices
```

## 项目结构

```
lib/
├── api/                    # API 接口
├── components/             # 组件库
│   ├── atoms/              # 原子组件
│   ├── common/             # 通用组件
│   └── business/           # 业务组件
├── config/                 # 配置文件
│   ├── env_config.dart     # 环境配置
│   └── app_config.dart     # 应用配置
├── core/                   # 核心功能
│   └── error/              # 错误处理
├── datasource/             # 数据源
├── models/                 # 数据模型
├── pages/                  # 页面
├── repository/             # 仓库层
├── routers/                # 路由
├── service/                # 服务
├── utils/                  # 工具类
├── values/                 # 常量
├── init_app.dart           # 应用初始化
└── main.dart               # 入口文件
```

## 创建新页面

### 1. 创建页面文件

在 `lib/pages/` 下创建新目录，例如 `my_page/`：

```
lib/pages/my_page/
├── my_page_view.dart       # 视图层
├── my_page_logic.dart      # 逻辑层
└── my_page_state.dart      # 状态层
```

### 2. 添加路由

在 `lib/routers/names.dart` 添加路由常量：

```dart
static const myPage = '/my_page';
```

在 `lib/routers/pages.dart` 注册路由：

```dart
GetPage(
  name: AppRoutes.myPage,
  page: () => const MyPage(),
),
```

### 3. 导出页面

在 `lib/pages/pages.dart` 导出：

```dart
export 'my_page/my_page_view.dart';
```

## 环境配置

### 切换环境

在 `main.dart` 中设置环境：

```dart
void main() async {
  // 设置环境
  EnvConfig.setEnvironment(Environment.dev);  // 开发环境
  // EnvConfig.setEnvironment(Environment.test);  // 测试环境
  // EnvConfig.setEnvironment(Environment.prod);  // 生产环境

  await initApp();
  runApp(const MyApp());
}
```

### 配置 API 地址

在 `lib/config/env_config.dart` 中修改：

```dart
static String get apiBaseUrl {
  switch (_currentEnv) {
    case Environment.dev:
      return 'https://your-dev-api.com';
    case Environment.test:
      return 'https://your-test-api.com';
    case Environment.prod:
      return 'https://your-prod-api.com';
  }
}
```

## 常用命令

```bash
# 代码格式化
dart format lib test

# 静态分析
flutter analyze

# 运行测试
flutter test

# 清理项目
flutter clean

# 构建 APK
flutter build apk

# 构建 iOS
flutter build ios
```

## 调试技巧

### 1. 查看日志

```dart
import 'package:tin_flutter_scafflod/utils/logger.dart';

Logger().info('信息日志');
Logger().error('错误日志');
Logger().debug('调试日志');
```

### 2. 使用 Flutter DevTools

```bash
flutter pub global activate devtools
flutter pub global run devtools
```

### 3. 热重载

- 按 `r` 键：热重载
- 按 `R` 键：热重启
- 按 `q` 键：退出

## 下一步

- 查看 [架构设计文档](./ARCHITECTURE.md)
- 查看 [组件使用文档](./COMPONENTS.md)
- 查看 [常见问题](./FAQ.md)
