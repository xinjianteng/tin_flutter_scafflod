/// 使用方法：final state = HomeState();
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/routers/routes.dart';
import 'package:tin_flutter_scafflod/utils/platform_util.dart';
import 'package:tin_flutter_scafflod/values/strings.dart';

class HomeAction {
  const HomeAction({
    required this.title,
    required this.description,
    required this.icon,
    required this.routeName,
  });

  final String title;
  final String description;
  final IconData icon;
  final String routeName;
}

class PlatformGuide {
  const PlatformGuide({
    required this.title,
    required this.note,
    required this.supported,
  });

  final String title;
  final String note;
  final bool supported;
}

class HomeState {
  final List<HomeAction> quickActions = const [
    HomeAction(
      title: AppStrings.actionRouting,
      description: AppStrings.actionRoutingDesc,
      icon: Icons.route_outlined,
      routeName: AppRoutes.setting,
    ),
    HomeAction(
      title: AppStrings.actionState,
      description: AppStrings.actionStateDesc,
      icon: Icons.verified_user_outlined,
      routeName: AppRoutes.profile,
    ),
    HomeAction(
      title: AppStrings.actionTheming,
      description: AppStrings.actionThemingDesc,
      icon: Icons.palette_outlined,
      routeName: AppRoutes.aboutApp,
    ),
    HomeAction(
      title: AppStrings.actionSamples,
      description: AppStrings.actionSamplesDesc,
      icon: Icons.extension_outlined,
      routeName: AppRoutes.listDemo,
    ),
  ];

  List<PlatformGuide> get platformGuides => [
        PlatformGuide(
          title: '原生权限/硬件插件',
          note: AppStrings.platformNativeNote,
          supported: PlatformUtil.supportsNativePlugins,
        ),
        PlatformGuide(
          title: '本地数据库（sqflite）',
          note: AppStrings.platformStorageNote,
          supported: PlatformUtil.supportsLocalDb,
        ),
        const PlatformGuide(
          title: '纯 Dart / UI 组件',
          note: AppStrings.platformCommonNote,
          supported: true,
        ),
      ];

  final RxBool isBusy = false.obs;
}
