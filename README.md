# Tin Flutter 脚手架

基于 GetX、Flutter Smart Dialog、ScreenUtil、PullToRefresh 的多端脚手架。内置欢迎页、登录状态示例、底部导航与常用工具，适合作为跨端模板起步。

## ✨ 特性

- 🎯 **完整的架构分层**：DataSource → Repository → Service → Logic → View
- 🎨 **丰富的组件库**：原子组件、通用组件、业务组件
- 🔧 **开箱即用**：登录、注册、列表、详情、通知等常用页面
- 🌍 **多端支持**：Android、iOS、HarmonyOS、Web、桌面
- 📱 **响应式设计**：基于 ScreenUtil 的屏幕适配
- 🎭 **状态管理**：GetX 响应式状态管理
- 🌓 **主题切换**：支持深色/浅色模式
- 🔄 **网络增强**：自动重试、请求缓存、错误处理
- 🔐 **权限管理**：统一的权限请求封装
- 🛠️ **开发工具**：环境配置、错误处理、日志系统

## 🚀 快速开始

### 1. 安装依赖
```bash
flutter pub get
```

### 2. 运行项目
```bash
# 运行到手机/模拟器
flutter run

# 运行到 Web
flutter run -d chrome

# 运行到桌面
flutter run -d windows  # macOS/linux
```

### 3. 查看组件展示
运行项目后，进入 **设置 → 组件展示** 查看所有可用组件。

## 📖 新手入门指南

### 第一步：了解项目结构

```
lib/
├── pages/          # 📄 页面（你主要工作的地方）
├── components/     # 🧩 可复用组件
├── api/            # 🌐 网络请求
├── models/         # 📦 数据模型
├── service/        # ⚙️ 全局服务
├── utils/          # 🔧 工具类
└── values/         # 🎨 常量配置
```

### 第二步：创建你的第一个页面

**1. 在 `lib/pages/` 创建新目录**
```bash
lib/pages/my_page/
├── my_page_view.dart    # 页面 UI
├── my_page_logic.dart   # 业务逻辑
└── my_page_state.dart   # 页面状态
```

**2. 编写页面代码**

`my_page_view.dart`：
```dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'my_page_logic.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(MyPageLogic());
    
    return Scaffold(
      appBar: AppBar(title: const Text('我的页面')),
      body: Center(
        child: Obx(() => Text('计数: ${logic.state.count}')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: logic.increment,
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

`my_page_logic.dart`：
```dart
import 'package:get/get.dart';
import 'my_page_state.dart';

class MyPageLogic extends GetxController {
  final state = MyPageState();

  void increment() {
    state.count++;
  }
}
```

`my_page_state.dart`：
```dart
import 'package:get/get.dart';

class MyPageState {
  final _count = 0.obs;
  int get count => _count.value;
  set count(int value) => _count.value = value;
}
```

**3. 注册路由**

在 `lib/routers/routes.dart` 添加：
```dart
static const myPage = '/my_page';
```

在 `lib/routers/pages.dart` 添加：
```dart
GetPage(
  name: AppRoutes.myPage,
  page: () => const MyPage(),
),
```

**4. 导航到新页面**
```dart
Get.toNamed(AppRoutes.myPage);
```

### 第三步：使用内置功能

#### 🌓 主题切换
```dart
// 获取主题服务
final themeService = Get.find<ThemeService>();

// 切换深色/浅色模式
themeService.toggleTheme();

// 设置指定主题
themeService.setTheme(ThemeMode.dark);  // 深色
themeService.setTheme(ThemeMode.light); // 浅色
themeService.setTheme(ThemeMode.system); // 跟随系统
```

#### 🌐 网络请求
```dart
// 获取 API 客户端
final client = Get.find<ApiClient>();

// 普通请求
final response = await client.getJson<User>(
  '/api/user',
  decoder: (data) => User.fromJson(data),
);

// 带缓存的请求（5分钟有效）
final response = await client.getJson<List<Article>>(
  '/api/articles',
  useCache: true,
  cacheDuration: Duration(minutes: 5),
  decoder: (data) => (data as List).map((e) => Article.fromJson(e)).toList(),
);

// POST 请求
final response = await client.postJson<LoginResult>(
  '/api/login',
  body: {'phone': '13800138000', 'code': '123456'},
  decoder: (data) => LoginResult.fromJson(data),
);
```

#### 🔐 权限请求
```dart
// 请求相机权限
bool granted = await PermissionUtil.requestCamera();

// 请求相册权限
bool granted = await PermissionUtil.requestPhotos();

// 请求定位权限
bool granted = await PermissionUtil.requestLocation();

// 自定义权限请求
bool granted = await PermissionUtil.requestWithDialog(
  permission: Permission.contacts,
  title: '通讯录权限',
  message: '需要访问通讯录以选择联系人',
);
```

#### 💾 本地存储
```dart
// 保存数据
await PrefsUtil.setString('username', 'John');
await PrefsUtil.setInt('age', 25);
await PrefsUtil.setBool('isVip', true);

// 读取数据
String? username = PrefsUtil.getString('username');
int? age = PrefsUtil.getInt('age');
bool? isVip = PrefsUtil.getBool('isVip');

// 加密存储（敏感数据）
await StorageUtil.setSecureString('token', 'xxx');
String? token = await StorageUtil.getSecureString('token');
```

#### 🎨 使用组件
```dart
// 按钮
AppButton(
  text: '提交',
  onPressed: () {},
)

// 输入框
AppInput(
  hintText: '请输入手机号',
  controller: phoneController,
)

// 加载状态
AppLoading()

// 空状态
AppEmpty(message: '暂无数据')

// 刷新列表
AppRefreshList<Article>(
  onRefresh: () async {
    // 刷新逻辑
  },
  onLoad: () async {
    // 加载更多逻辑
  },
  itemBuilder: (article) => ArticleCard(article: article),
)
```

#### 🔔 弹窗提示
```dart
// Toast 提示
SmartDialog.showToast('操作成功');

// 加载中
SmartDialog.showLoading(msg: '加载中...');
SmartDialog.dismiss();

// 确认对话框
SmartDialog.show(
  builder: (_) => AlertDialog(
    title: Text('提示'),
    content: Text('确定要删除吗？'),
    actions: [
      TextButton(onPressed: () => SmartDialog.dismiss(), child: Text('取消')),
      TextButton(onPressed: () {
        SmartDialog.dismiss();
        // 执行删除
      }, child: Text('确定')),
    ],
  ),
);
```

### 第四步：常用开发场景

#### 场景1：添加一个列表页面
参考 `lib/pages/list/` 示例，已包含：
- 下拉刷新
- 上拉加载更多
- 空状态处理
- 错误处理

#### 场景2：实现登录功能
参考 `lib/pages/login/` 示例，已包含：
- 手机号验证
- 验证码登录
- 登录状态持久化
- 自动跳转

#### 场景3：修改主题颜色
编辑 `lib/values/colors.dart`：
```dart
class AppColors {
  static const Color primary = Color(0xFF2196F3); // 改成你的主色调
  static const Color secondary = Color(0xFFFF9800);
  // ...
}
```

#### 场景4：修改 API 地址
编辑 `lib/api/api_config.dart`：
```dart
class ApiConfig {
  static const String baseUrl = 'https://your-api.com'; // 改成你的 API 地址
  // ...
}
```

## 🎯 核心概念

### 架构分层
```
View (UI)
  ↓ 调用
Logic (业务逻辑)
  ↓ 调用
Repository (数据组合)
  ↓ 调用
DataSource (数据获取)
```

### 状态管理
使用 GetX 的响应式编程：
```dart
// 定义响应式变量
final count = 0.obs;

// 修改值（自动触发 UI 更新）
count.value = 10;

// 在 UI 中使用
Obx(() => Text('${count.value}'))
```

### 路由导航
```dart
// 跳转到新页面
Get.toNamed('/page');

// 替换当前页面
Get.offNamed('/page');

// 清空栈并跳转
Get.offAllNamed('/page');

// 返回上一页
Get.back();

// 传递参数
Get.toNamed('/page', arguments: {'id': 123});

// 接收参数
final args = Get.arguments;
```

## 🔧 跨端开发指引

| 能力/插件 | 移动 | 桌面 | Web | 说明 |
| --- | --- | --- | --- | --- |
| `permission_handler` | ✅ | ✅ | 🚫 | Web 构建需移除或条件编译 |
| `sqflite` | ✅ | ✅ | 🚫 | Web 推荐用 `hive` 或 `indexed_db` |
| GetX、SmartDialog、ScreenUtil | ✅ | ✅ | ✅ | 全端可用 |

**Web 端适配**：
```dart
// 使用 PlatformUtil 判断平台
if (!PlatformUtil.isWeb) {
  // 只在非 Web 端执行
  await PermissionUtil.requestCamera();
}
```

## 📚 进阶学习

### 推荐阅读顺序
1. 查看 `lib/pages/home/` - 了解页面结构
2. 查看 `lib/pages/list/` - 学习列表实现
3. 查看 `lib/pages/login/` - 学习表单和验证
4. 查看 `lib/components/` - 学习组件封装
5. 查看 `lib/api/` - 学习网络请求

### 官方文档
- [Flutter 中文网](https://flutter.cn)
- [GetX 文档](https://github.com/jonataslaw/getx)
- [Flutter Smart Dialog](https://github.com/fluttercandies/flutter_smart_dialog)

## 🐛 常见问题

### Q: 如何调试网络请求？
A: 查看控制台日志，所有请求都会打印 `[http]` 标签。

### Q: 如何清除缓存？
A: 调用 `ApiCache.clear()` 清除网络缓存，调用 `PrefsUtil.clear()` 清除本地存储。

### Q: 如何添加新的全局服务？
A: 在 `lib/service/` 创建服务类，然后在 `lib/init_app.dart` 中注册。

### Q: 页面跳转后如何传递数据？
A: 使用 `Get.toNamed('/page', arguments: data)` 传递，用 `Get.arguments` 接收。

### Q: 如何实现页面间通信？
A: 使用 GetX 的全局状态管理或 `Get.find<YourService>()` 获取共享服务。

## 📝 开发命令

```bash
# 格式化代码
dart format lib test

# 静态分析
flutter analyze

# 运行测试
flutter test

# 清理构建
flutter clean

# 构建 APK
flutter build apk

# 构建 Web
flutter build web
```

## 🎨 自定义建议

1. **替换 Logo**：修改 `assets/images/` 中的图片
2. **修改应用名**：编辑 `lib/values/strings.dart` 中的 `appName`
3. **调整主题**：编辑 `lib/service/theme_service.dart` 中的 `lightTheme` 和 `darkTheme`
4. **配置 API**：编辑 `lib/api/api_config.dart`
5. **添加页面**：参考上面的"第二步：创建你的第一个页面"

## 📄 更多文档

- [CLAUDE.md](./CLAUDE.md) - AI 辅助开发指南（包含详细的架构说明）

## 💡 提示

- 所有全局服务都在 `lib/init_app.dart` 中初始化
- 路由配置在 `lib/routers/pages.dart`
- 常量配置在 `lib/values/`
- 工具类在 `lib/utils/`
- 组件按 `atoms → common → business` 分层，避免跨层引用

---

**祝你开发愉快！** 🎉

如有问题，欢迎提 Issue 或查看代码注释。
