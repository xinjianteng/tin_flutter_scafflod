class AppStrings {
  static const String appName = 'Tin Flutter 脚手架';
  static const String appVersion = 'v1.0.0';
  static const String appAuthor = 'Tin';
  static const String appTagline = '跨端、可裁剪的基础模板';

  static const String login = '登录';
  static const String logout = '退出登录';
  static const String register = '注册';

  static const String home = '首页';
  static const String explore = '发现';
  static const String profile = '我的';
  static const String search = '搜索';
  static const String setting = '设置';
  static const String about = '关于';

  static const String empty = '暂无数据';

  static const String scaffoldIntroTitle = '脚手架示例';
  static const String scaffoldIntroDesc = '查看目录结构与示例能力';
  static const String platformGuideTitle = '跨端依赖指引';
  static const String platformGuideDesc = '按平台裁剪可选插件，避免无关依赖';
  static const String platformNativeNote =
      '权限、相机等原生插件仅支持移动/桌面，Web 构建请移除 permission_handler 等依赖。';
  static const String platformStorageNote =
      'sqflite 仅移动/桌面可用，Web 推荐使用 indexed_db 或 hive 替代。';
  static const String platformCommonNote =
      '纯 Dart 与 UI 组件（GetX、SmartDialog、ScreenUtil）可全端使用。';

  static const String actionRouting = '路由与中间件';
  static const String actionRoutingDesc = 'AppRoutes + GetMiddleware 管理导航跳转';
  static const String actionState = '全局状态与持久化';
  static const String actionStateDesc = 'OauthService 搭配 PrefsUtil 示例登录状态';
  static const String actionTheming = '主题与尺寸';
  static const String actionThemingDesc = 'AppColors、AppDimens、AppStyles 统一样式';
  static const String actionSamples = '可插拔能力';
  static const String actionSamplesDesc = '按需启用原生/数据库能力，保持脚手架精简';

  static const String searchHint = '输入关键字开始搜索';
  static const String searchEmpty = '这里展示搜索结果列表';

  static const String loginTitle = '快速登录示例';
  static const String loginTip = '使用手机号验证码快速登录，接口为模拟实现。';
  static const String loginSendCode = '获取验证码';
  static const String loginCountdown = '验证码已发送';

  static const String profileUnknownUser = '未登录用户';
  static const String profileLoginState = '当前状态';
  static const String profileDetail = '个人信息';

  static const String settingFollowSystem = '跟随系统深色模式';
  static const String settingClearMock = '清除模拟登录数据';
  static const String settingAbout = '关于';
  static const String settingAboutSubTitle = '查看版本与作者信息';
  static const String settingFeedback = '问题反馈';
  static const String settingListDemo = '列表刷新示例';
  static const String settingProfileDetail = '个人信息';
  static const String settingPersonalizeTip =
      '把你的个性化设置项添加在这里，比如主题、通知、缓存清理等。';

  static const String listTitle = '列表刷新';
  static const String listEmpty = '暂无列表数据';
  static const String listError = '列表加载失败';

  static const String feedbackTitle = '问题反馈';
  static const String feedbackTip = '我们会尽快处理你的反馈';

  static const String searchHistory = '最近搜索';
  static const String searchResult = '搜索结果';

  static const String aboutWebsite = '官方网站';
  static const String aboutAgreement = '用户协议';
  static const String aboutPrivacy = '隐私政策';

  static const String notFoundTitle = '页面不存在';
  static const String notFoundMessage = '没找到对应的页面';
  static const String backToHome = '返回首页';
}
