# 常见问题 FAQ

## 安装和配置

### Q: 运行 `flutter pub get` 失败怎么办？

**A:** 可能的原因和解决方案：

1. **网络问题**：配置镜像源
   ```bash
   export PUB_HOSTED_URL=https://pub.flutter-io.cn
   export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
   ```

2. **依赖冲突**：删除 `pubspec.lock` 后重试
   ```bash
   rm pubspec.lock
   flutter pub get
   ```

3. **Git 依赖问题**：确保可以访问 gitcode.com

### Q: 如何切换 Flutter 版本？

**A:** 使用 FVM (Flutter Version Management)：

```bash
# 安装 FVM
dart pub global activate fvm

# 安装指定版本
fvm install 3.6.2

# 使用指定版本
fvm use 3.6.2

# 运行项目
fvm flutter run
```

## 开发问题

### Q: 如何添加新的依赖包？

**A:**

1. 在 `pubspec.yaml` 中添加依赖
2. 运行 `flutter pub get`
3. 导入并使用

```yaml
dependencies:
  your_package: ^1.0.0
```

### Q: GetX 路由跳转失败？

**A:** 检查以下几点：

1. 路由是否在 `routers/pages.dart` 中注册
2. 路由名称是否正确（使用 `AppRoutes` 常量）
3. 是否在 `MaterialApp` 中配置了 GetX

```dart
GetMaterialApp(
  initialRoute: AppRoutes.welcome,
  getPages: AppPages.routes,
)
```

### Q: 如何处理异步操作？

**A:** 使用统一的错误处理：

```dart
try {
  final result = await repository.fetchData();
  // 处理成功
} catch (e) {
  final failure = ErrorHandler.handleError(e);
  ErrorHandler.showError(failure);
}
```

### Q: 状态管理最佳实践？

**A:**

1. 使用 GetX 的响应式变量
2. Logic 层处理业务逻辑
3. State 层管理状态
4. View 层只负责 UI

```dart
// State
final RxBool isLoading = false.obs;

// Logic
void loadData() async {
  state.isLoading.value = true;
  // 加载数据
  state.isLoading.value = false;
}

// View
Obx(() => state.isLoading.value
  ? CircularProgressIndicator()
  : DataWidget()
)
```

## 跨平台问题

### Q: Web 端运行报错？

**A:** Web 端不支持某些原生插件，需要：

1. 移除或条件编译原生插件
2. 使用 `PlatformUtil` 判断平台

```dart
if (PlatformUtil.isWeb) {
  // Web 端逻辑
} else {
  // 原生端逻辑
}
```

### Q: HarmonyOS 适配注意事项？

**A:**

1. 使用项目中的 HarmonyOS 适配版本依赖
2. 不要随意升级依赖版本
3. 参考 `pubspec.yaml` 中的依赖配置

### Q: 如何支持桌面端？

**A:**

1. 启用桌面支持
   ```bash
   flutter config --enable-windows-desktop
   flutter config --enable-macos-desktop
   flutter config --enable-linux-desktop
   ```

2. 运行桌面应用
   ```bash
   flutter run -d windows
   flutter run -d macos
   flutter run -d linux
   ```

## 性能优化

### Q: 如何优化列表性能？

**A:**

1. 使用 `ListView.builder` 而不是 `ListView`
2. 使用 `const` 构造函数
3. 避免在 `build` 方法中创建对象
4. 使用 `AutomaticKeepAliveClientMixin` 保持状态

### Q: 如何减小包体积？

**A:**

1. 移除未使用的依赖
2. 使用 `--split-per-abi` 构建
3. 启用代码混淆
4. 压缩图片资源

```bash
flutter build apk --split-per-abi --obfuscate --split-debug-info=./debug-info
```

### Q: 内存泄漏如何排查？

**A:**

1. 使用 Flutter DevTools 的 Memory 面板
2. 检查 Controller 是否正确释放
3. 检查 Stream 是否关闭
4. 检查 Timer 是否取消

## 调试问题

### Q: 如何查看网络请求？

**A:**

1. 使用 Flutter DevTools 的 Network 面板
2. 在 ApiClient 中添加日志拦截器
3. 使用 Charles 或 Fiddler 抓包

### Q: 如何调试原生代码？

**A:**

- **Android**: 使用 Android Studio 的调试功能
- **iOS**: 使用 Xcode 的调试功能

### Q: 热重载不生效？

**A:**

1. 尝试热重启（按 `R`）
2. 检查是否修改了 `main()` 函数
3. 检查是否修改了全局变量
4. 重新运行应用

## 发布问题

### Q: 如何配置应用签名？

**A:**

**Android**:
1. 生成签名文件
2. 配置 `android/key.properties`
3. 修改 `android/app/build.gradle`

**iOS**:
1. 在 Xcode 中配置证书
2. 配置 Bundle Identifier
3. 配置 Provisioning Profile

### Q: 如何发布到应用商店？

**A:**

**Android (Google Play)**:
```bash
flutter build appbundle
```

**iOS (App Store)**:
```bash
flutter build ios --release
```

然后使用 Xcode 上传到 App Store Connect

## 其他问题

### Q: 如何贡献代码？

**A:**

1. Fork 项目
2. 创建功能分支
3. 提交代码
4. 创建 Pull Request

### Q: 遇到问题如何寻求帮助？

**A:**

1. 查看项目文档
2. 搜索 GitHub Issues
3. 提交新的 Issue
4. 联系项目维护者

### Q: 如何更新脚手架？

**A:**

1. 查看更新日志
2. 拉取最新代码
3. 解决冲突
4. 测试功能

```bash
git pull origin main
flutter pub get
flutter clean
flutter run
```
