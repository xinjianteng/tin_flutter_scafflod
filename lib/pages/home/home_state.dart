import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/utils/platform_util.dart';
import '/values/strings.dart';

class HomeAction {
  const HomeAction({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;
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
    ),
    HomeAction(
      title: AppStrings.actionState,
      description: AppStrings.actionStateDesc,
      icon: Icons.verified_user_outlined,
    ),
    HomeAction(
      title: AppStrings.actionTheming,
      description: AppStrings.actionThemingDesc,
      icon: Icons.palette_outlined,
    ),
    HomeAction(
      title: AppStrings.actionSamples,
      description: AppStrings.actionSamplesDesc,
      icon: Icons.extension_outlined,
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
