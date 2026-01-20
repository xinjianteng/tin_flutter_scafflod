// 应用入口：绑定全局依赖、刷新配置与路由。
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'init_app.dart';
import 'routers/routes.dart';
import 'service/oauth_service.dart';
import 'service/theme_service.dart';
import 'utils/logger.dart';
import 'values/values.dart';

OauthService get oauthService => Get.find<OauthService>();

Future<void> main() async {
  await initApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = Get.find<ThemeService>();

    return ScreenUtilInit(
      designSize: AppDimens.deviceSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => RefreshConfiguration(
        headerBuilder: () => const ClassicHeader(
          height: 45.0,
          releaseText: '松开刷新',
          refreshingText: '刷新中...',
          completeText: '刷新完成',
          idleText: '下拉刷新',
        ),
        footerBuilder: () => const ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 100),
          canLoadingText: '松开加载更多',
          noDataText: '没有更多数据了',
          loadingText: '加载中...',
          idleText: '上拉加载',
        ),
        hideFooterWhenNotFull: true,
        headerTriggerDistance: 80.h,
        maxOverScrollExtent: 100.h,
        footerTriggerDistance: 150.h,
        maxUnderScrollExtent: 0,
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed: true,
        enableBallisticLoad: true,
        child: GetMaterialApp(
          color: AppColors.primary,
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeService.lightTheme,
          darkTheme: ThemeService.darkTheme,
          themeMode: themeService.themeMode,
          initialRoute: AppRoutes.welcome,
          getPages: AppPages.routes,
          unknownRoute: AppPages.unknownRoute,
          builder: FlutterSmartDialog.init(),
          navigatorObservers: [AppPages.observer, FlutterSmartDialog.observer],
          enableLog: kDebugMode,
          logWriterCallback: (String text, {bool isError = false}) {
            Logger().log(text, isError: isError);
          },
        ),
      ),
    );
  }
}
