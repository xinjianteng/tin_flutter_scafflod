# 代码生成工具使用指南

本项目提供了便捷的代码生成脚本，帮助快速创建新页面和组件。

## 创建新页面

### Linux / macOS

```bash
# 给脚本添加执行权限（首次使用）
chmod +x scripts/create_page.sh

# 创建新页面
./scripts/create_page.sh MyPage
```

### Windows

```cmd
# 创建新页面
scripts\create_page.bat MyPage
```

### 生成的文件

脚本会在 `lib/pages/mypage/` 目录下创建以下文件：

```
lib/pages/mypage/
├── mypage_view.dart    # 视图层
├── mypage_logic.dart   # 逻辑层
└── mypage_state.dart   # 状态层
```

### 后续步骤

脚本执行后会提示你完成以下配置：

1. **添加路由常量** (`lib/routers/names.dart`)
   ```dart
   static const mypage = '/mypage';
   ```

2. **注册路由** (`lib/routers/pages.dart`)
   ```dart
   GetPage(
     name: AppRoutes.mypage,
     page: () => const MyPagePage(),
   ),
   ```

3. **导出页面** (`lib/pages/pages.dart`)
   ```dart
   export 'mypage/mypage_view.dart';
   ```

4. **使用路由跳转**
   ```dart
   Get.toNamed(AppRoutes.mypage);
   ```

## 示例

### 创建用户详情页

```bash
# Linux/macOS
./scripts/create_page.sh UserDetail

# Windows
scripts\create_page.bat UserDetail
```

生成的文件：
- `lib/pages/userdetail/userdetail_view.dart`
- `lib/pages/userdetail/userdetail_logic.dart`
- `lib/pages/userdetail/userdetail_state.dart`

### 创建订单列表页

```bash
# Linux/macOS
./scripts/create_page.sh OrderList

# Windows
scripts\create_page.bat OrderList
```

生成的文件：
- `lib/pages/orderlist/orderlist_view.dart`
- `lib/pages/orderlist/orderlist_logic.dart`
- `lib/pages/orderlist/orderlist_state.dart`

## 注意事项

1. **命名规范**：
   - 使用大驼峰命名（PascalCase）
   - 例如：`UserProfile`、`OrderDetail`、`ProductList`

2. **避免重复**：
   - 创建前检查页面是否已存在
   - 如果目录已存在，脚本会覆盖原有文件

3. **手动配置**：
   - 脚本只生成页面文件
   - 路由配置需要手动添加
   - 建议按照脚本提示的步骤操作

## 自定义模板

如果需要自定义生成的代码模板，可以编辑脚本文件：
- Linux/macOS: `scripts/create_page.sh`
- Windows: `scripts/create_page.bat`

## 故障排除

### Linux/macOS 权限问题

```bash
# 如果提示权限不足
chmod +x scripts/create_page.sh
```

### Windows 执行策略问题

```cmd
# 如果无法执行脚本，以管理员身份运行 PowerShell
Set-ExecutionPolicy RemoteSigned
```

### 路径问题

确保在项目根目录下执行脚本：
```bash
# 检查当前目录
pwd  # Linux/macOS
cd   # Windows

# 应该看到 lib、scripts 等目录
ls   # Linux/macOS
dir  # Windows
```
