// App 初始化：绑定 Flutter 引擎、偏好存储、核心服务与网络客户端。
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'api/api_client.dart';
import 'service/oauth_service.dart';
import 'utils/utils.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefsUtil.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  if (!Get.isRegistered<OauthService>()) {
    await Get.putAsync(() async => OauthService(), permanent: true);
  }

  if (!Get.isRegistered<ApiClient>()) {
    Get.put(ApiClient(), permanent: true);
  }

  Get.log('应用初始化完成');
}
