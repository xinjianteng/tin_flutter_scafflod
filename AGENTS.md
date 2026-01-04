# 仓库指南

## 项目结构与模块组织
- 主要 Dart 源码位于 `lib/`：`pages/`（GetX 视图/逻辑）、`routers/`（路由与中间件）、`service/`（全局服务，如 OAuth）、`utils/`（日志/偏好/加密）、`values/`（主题/常量）、`api/`（GetConnect 封装）、`models/`（数据模型）。应用入口是 `lib/main.dart`；启动在 `lib/init_app.dart`。
- 平台外壳位于 `android/`、`ios/`、`macos/`、`linux/`、`windows/`、`web/` 和 `ohos/`；共享资源在 `assets/images/`。
- 测试位于 `test/`（组件/单元）。在合适时将新测试套件放在相关功能模块旁。

## 构建、测试与开发命令
- `flutter pub get` - 安装依赖。
- `flutter run`（可选 `-d windows` / `-d macos` / `-d chrome`） - 本地运行。
- `flutter analyze` - 使用仓库 lint 规则进行静态分析。
- `dart format lib test` - 格式化 Dart 代码（2 空格缩进，默认行宽）。
- `flutter test` - 运行组件/单元测试；本地需要覆盖率时添加 `--coverage`。

## 代码风格与命名约定
- 遵循 Flutter lints（`analysis_options.yaml`）；除非必须有状态，优先使用不可变组件。
- Dart 风格：2 空格缩进，文件名 `lower_snake_case`，类型 `UpperCamelCase`，成员 `lowerCamelCase`。保持组件的 build 方法简洁；增长时抽取为组件/扩展。
- 将功能代码组织在 `lib/pages/<feature>/`；在 `lib/routers/pages.dart` 中集中管理路由名称/常量。

## 测试指南
- 测试命名 `<feature>_test.dart`；将 golden/组件测试与 UI 组件共置，单元测试与 utils/services 共置。
- 新逻辑需覆盖成功与失败路径；优先 mock 服务，避免真实接口。例如：`flutter test test/widget_test.dart`。
- 保持测试夹具轻量且确定性；避免依赖真实时间和网络。

## 提交与 PR 指南
- 提交历史从 `init` 开始；继续使用简洁的祈使语气信息（如 `feat: add profile login flow`、`fix: handle expired token`）。
- PR 应描述范围、风险和测试说明；如有，关联 issue/任务。
- 提供 UI 变更的截图/gif，并说明平台影响；在请求评审前确保 `flutter analyze` 和 `flutter test` 通过。
