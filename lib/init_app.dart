/// 使用方法：await initApp();
// App 初始化：绑定 Flutter 引擎、偏好存储、核心服务与网络客户端。
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'api/api_client.dart';
import 'datasource/auth_remote_data_source.dart';
import 'datasource/list_remote_data_source.dart';
import 'repository/auth_repository.dart';
import 'repository/list_repository.dart';
import 'service/oauth_service.dart';
import 'service/theme_service.dart';
import 'utils/utils.dart';

Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefsUtil.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  if (!Get.isRegistered<ThemeService>()) {
    Get.put(ThemeService(), permanent: true);
  }

  if (!Get.isRegistered<OauthService>()) {
    Get.put(OauthService(), permanent: true);
  }

  if (!Get.isRegistered<ApiClient>()) {
    Get.put(ApiClient(), permanent: true);
  }

  if (!Get.isRegistered<AuthRemoteDataSource>()) {
    Get.put(
      AuthRemoteDataSource(apiClient: Get.find<ApiClient>()),
      permanent: true,
    );
  }

  if (!Get.isRegistered<AuthRepository>()) {
    Get.put(
      AuthRepository(remote: Get.find<AuthRemoteDataSource>()),
      permanent: true,
    );
  }

  if (!Get.isRegistered<ListRemoteDataSource>()) {
    Get.put(
      ListRemoteDataSource(apiClient: Get.find<ApiClient>()),
      permanent: true,
    );
  }

  if (!Get.isRegistered<ListRepository>()) {
    Get.put(
      ListRepository(remote: Get.find<ListRemoteDataSource>()),
      permanent: true,
    );
  }

  Get.log('应用初始化完成');
}
