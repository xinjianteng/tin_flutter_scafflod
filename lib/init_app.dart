/// App 初始化：绑定 Flutter 引擎、偏好存储与核心服务、网络客户端。
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'api/api_client.dart';
import 'service/oauth_service.dart';
import 'utils/utils.dart';

/// App 初始化
Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 本地偏好与屏幕适配
  await PrefsUtil.ensureInitialized();
  ScreenUtil.ensureScreenSize();

  // 仅注册一次，确保全局可用
  if (!Get.isRegistered<OauthService>()) {
    await Get.putAsync(() async => OauthService(), permanent: true);
  }

  // 注册 GetConnect 客户端
  if (!Get.isRegistered<ApiClient>()) {
    Get.put(ApiClient(), permanent: true);
  }

  Get.log('应用初始化完成');
}
