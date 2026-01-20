# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

这是一个基于 GetX、Flutter Smart Dialog、ScreenUtil、PullToRefresh 的多端 Flutter 脚手架，支持 Android、iOS、HarmonyOS、Web、桌面等平台。项目使用 GetX 进行状态管理和路由，内置登录状态管理、底部导航和常用功能页面。

## 开发命令

```bash
# 安装依赖
flutter pub get

# 运行应用
flutter run

# 代码格式化
dart format lib test

# 静态分析
flutter analyze

# 运行测试
flutter test
```

## 架构分层

项目采用清晰的分层架构：

- **View 层** (`pages/*/*_view.dart`)：负责页面布局与导航
- **ViewModel 层** (`pages/*/*_logic.dart`)：负责业务流程与状态协调
- **State/Model 层** (`pages/*/*_state.dart` + `models/`)：管理页面状态与数据模型
- **Repository 层** (`repository/`)：负责业务数据组合
- **DataSource 层** (`datasource/`)：负责远端/本地数据获取
- **组件层级**：`atoms -> common -> business -> pages` 逐层依赖，避免跨层引用

## 核心服务初始化

应用启动时通过 `initApp()` (lib/init_app.dart) 初始化核心服务，按顺序注册：
1. PrefsUtil（偏好存储）
2. ScreenUtil（屏幕适配）
3. OauthService（登录状态管理）
4. ApiClient（网络客户端）
5. DataSource 和 Repository 层服务

所有核心服务使用 `Get.put(..., permanent: true)` 注册为全局单例。

## 路由管理

- 路由常量定义在 `lib/routers/routes.dart` 的 `AppRoutes` 类中
- 路由配置在 `lib/routers/pages.dart` 的 `AppPages.routes` 中
- 使用 GetX 路由：`Get.toNamed(AppRoutes.xxx)`
- 欢迎页使用 `RouteWelcomeMiddleware` 中间件处理首启和登录态跳转逻辑

## 登录状态管理

- `OauthService` (lib/service/oauth_service.dart) 管理全局登录状态
- 使用 `StorageUtil.setSecureString/getSecureString` 持久化 OAuth 数据
- 通过 `Get.find<OauthService>()` 访问登录状态
- `ApiClient` 自动从 `OauthService` 获取 token 并注入到请求头

## 网络请求

- `ApiClient` (lib/api/api_client.dart) 基于 GetConnect 封装
- 自动注入 Bearer Token
- 统一的响应包装：`ApiResponse<T>`
- 使用方法：
  ```dart
  final client = Get.find<ApiClient>();
  final response = await client.getJson<MyModel>(
    '/api/path',
    decoder: (data) => MyModel.fromJson(data),
  );
  ```

## 跨端兼容性

- 使用 `PlatformUtil` (lib/utils/platform_util.dart) 判断运行平台
- Web 端需要移除或条件编译原生插件：`permission_handler`、`sqflite*`
- 纯 Dart 库（GetX、SmartDialog、ScreenUtil）全端可用

## 依赖说明

项目使用 HarmonyOS 适配版本的依赖（从 gitcode.com 拉取），包括：
- GetX (br_4.7.2_ohos)
- shared_preferences (br_shared_preferences-v2.5.3_ohos)
- path_provider (br_path_provider-v2.1.5_ohos)
- permission_handler (br_permission_handler_v11.3.1_ohos)
- sqflite 系列

## 组件分层规范

- `lib/components/atoms/`：原子组件（按钮、输入框、文本、加载）
- `lib/components/common/`：通用组件（弹窗、空状态、刷新列表）
- `lib/components/business/`：业务组件（登录表单、用户卡片）
- 组件应遵循从下到上的依赖关系，不可跨层或反向引用

## 常用工具

- `PrefsUtil`：偏好存储统一访问（基于 shared_preferences）
- `StorageUtil`：安全存储（加密存储敏感数据）
- `Logger`：日志输出
- `PlatformUtil`：平台判断
- `ValidateUtil`：表单验证
- `AppUtil`：应用通用工具

## 常量管理

- `lib/values/strings.dart`：文案常量
- `lib/values/colors.dart`：配色常量
- `lib/values/dimens.dart`：尺寸常量
- `lib/values/constant.dart`：其他常量

## 新增页面流程

1. 在 `lib/pages/` 创建页面目录
2. 创建 `xxx_view.dart`、`xxx_logic.dart`、`xxx_state.dart`
3. 在 `lib/routers/routes.dart` 添加路由常量
4. 在 `lib/routers/pages.dart` 注册路由
5. 在 `lib/pages/pages.dart` 导出页面类
