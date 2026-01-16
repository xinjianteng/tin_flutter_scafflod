import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/oauth_service.dart';
import '../../utils/utils.dart';
import '../routes.dart';

/// 欢迎页守卫：根据首次启动/登录状态决定跳转入口
class RouteWelcomeMiddleware extends GetMiddleware {
  RouteWelcomeMiddleware({required int priority}) : super(priority: priority);

  @override
  RouteSettings? redirect(String? route) {
    if (PrefsUtil().isFirstOpen) {
      return null;
    }

    if (!Get.isRegistered<OauthService>()) {
      return null;
    }
    final authService = Get.find<OauthService>();

    if (authService.isLogin.value) {
      return const RouteSettings(name: AppRoutes.application);
    } else {
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
