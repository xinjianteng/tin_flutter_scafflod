# Tin Flutter 脚手架

基于 GetX、Flutter Smart Dialog、ScreenUtil、PullToRefresh 的多端脚手架，内置欢迎页守卫、登录状态管理、底部导航壳和常用工具/常量，适合作为后续项目模板。

## 快速开始
1. 安装依赖
   ```bash
   flutter pub get
   ```
2. 运行
   ```bash
   flutter run
   ```
3. 生产包请自行配置签名、包名与图标。

## 目录说明
```
lib/
├── api/                    # 接口定义（待扩展）@
├── models/                 # 数据模型（Oauth/User 等）
├── pages/                  # 页面模块
│   ├── application/        # 主壳+底部导航
│   ├── home/               # 首页示例卡片
│   ├── search/             # 搜索页占位
│   ├── profile/            # 个人中心（模拟登录）
│   ├── login/              # 登录页模板
│   ├── setting/            # 设置页模板
│   ├── about/              # 关于页
│   ├── not_found/          # 404 占位
│   └── welcome/            # 欢迎页+倒计时守卫
├── routers/                # 路由、守卫、中间件
├── service/                # 全局服务（Oauth 持久化等）
├── utils/                  # 工具（日志、偏好存储、加解密等）
├── values/                 # 配色、尺寸、文案常量
├── init_app.dart           # 启动初始化（Prefs/Oauth 注册）
└── main.dart               # 入口，挂载刷新配置、路由和全局导航监控
assets/
└── images/                 # 欢迎页/Logo 可替换
```

## 已内置能力
- GetX 路由与依赖注入，欢迎页中间件根据首启/登录态跳转。
- ScreenUtil 适配、SmartDialog 弹窗、PullToRefresh 全局头尾配置。
- OauthService 持久化登录状态，Profile/Login 页提供模拟登录示例。
- PrefsUtil 统一偏好存储访问；Logger 简单日志输出。
- 文案/配色/尺寸集中在 `lib/values/`，便于快速换肤与统一文案。
- API 入口：`lib/api/` 提供 GetConnect 封装、配置和统一返回体，可直接注入使用。

## 常用命令
- 格式化：`dart format lib test`
- 分析：`flutter analyze`
- 测试：`flutter test`

## 替换项提示
- 将 `assets/images/` 中的占位图替换为真实资源；如暂缺会自动降级不显示。
- 按领域在 `pages/` 与 `routers/pages.dart` 添加新模块，使用 `AppRoutes` 管理路由常量。
- 根据实际业务实现登录接口，替换 `LoginLogic.mockLogin` 与 `OauthService` 的持久化逻辑。
