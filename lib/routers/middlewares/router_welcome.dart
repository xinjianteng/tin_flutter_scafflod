import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../utils/utils.dart';
import '../routes.dart';

/// 欢迎页守卫：根据首次启动/登录状态决定跳转入口
class RouteWelcomeMiddleware extends GetMiddleware {
  @override
  int? priority;

  RouteWelcomeMiddleware({required this.priority});

  @override
  RouteSettings? redirect(String? route) {
    if (PrefsUtil().isFirstOpen) {
      return null;
    }

    if (oauthService.isLogin.value) {
      return const RouteSettings(name: AppRoutes.application);
    } else {
      return const RouteSettings(name: AppRoutes.login);
    }
  }
}
