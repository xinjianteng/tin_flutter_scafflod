@echo off
REM Flutter 页面生成脚本 (Windows)
REM 用法: scripts\create_page.bat PageName

if "%1"=="" (
  echo 错误: 请提供页面名称
  echo 用法: scripts\create_page.bat PageName
  exit /b 1
)

set PAGE_NAME=%1
set PAGE_NAME_LOWER=%PAGE_NAME%
set PAGE_DIR=lib\pages\%PAGE_NAME_LOWER%

echo 正在创建页面: %PAGE_NAME%
echo 目录: %PAGE_DIR%

REM 创建目录
if not exist "%PAGE_DIR%" mkdir "%PAGE_DIR%"

REM 创建 State 文件
(
echo library;
echo.
echo /// 使用方法：final state = %PAGE_NAME%State^(^);
echo import 'package:get/get.dart';
echo.
echo class %PAGE_NAME%State {
echo   final RxBool isLoading = false.obs;
echo }
) > "%PAGE_DIR%\%PAGE_NAME_LOWER%_state.dart"

REM 创建 Logic 文件
(
echo library;
echo.
echo /// 使用方法：Get.put^(%PAGE_NAME%Logic^(^)^);
echo import 'package:get/get.dart';
echo import '%PAGE_NAME_LOWER%_state.dart';
echo.
echo class %PAGE_NAME%Logic extends GetxController {
echo   final %PAGE_NAME%State state = %PAGE_NAME%State^(^);
echo.
echo   @override
echo   void onInit^(^) {
echo     super.onInit^(^);
echo     loadData^(^);
echo   }
echo.
echo   Future^<void^> loadData^(^) async {
echo     state.isLoading.value = true;
echo     try {
echo       // TODO: 加载数据
echo       await Future.delayed^(const Duration^(seconds: 1^)^);
echo     } catch ^(e^) {
echo       Get.snackbar^('错误', e.toString^(^)^);
echo     } finally {
echo       state.isLoading.value = false;
echo     }
echo   }
echo }
) > "%PAGE_DIR%\%PAGE_NAME_LOWER%_logic.dart"

REM 创建 View 文件
(
echo library;
echo.
echo /// 使用方法：Get.toNamed^(AppRoutes.%PAGE_NAME_LOWER%^);
echo import 'package:flutter/material.dart';
echo import 'package:get/get.dart';
echo import '%PAGE_NAME_LOWER%_logic.dart';
echo.
echo class %PAGE_NAME%Page extends StatelessWidget {
echo   const %PAGE_NAME%Page^({super.key}^);
echo.
echo   @override
echo   Widget build^(BuildContext context^) {
echo     final logic = Get.put^(%PAGE_NAME%Logic^(^)^);
echo     final state = logic.state;
echo     final theme = Theme.of^(context^);
echo.
echo     return Scaffold^(
echo       appBar: AppBar^(
echo         title: const Text^('%PAGE_NAME%'^),
echo         centerTitle: true,
echo       ^),
echo       body: Obx^(^(^) {
echo         if ^(state.isLoading.value^) {
echo           return const Center^(child: CircularProgressIndicator^(^)^);
echo         }
echo.
echo         return Center^(
echo           child: Text^(
echo             '%PAGE_NAME% 页面',
echo             style: theme.textTheme.headlineMedium,
echo           ^),
echo         ^);
echo       }^),
echo     ^);
echo   }
echo }
) > "%PAGE_DIR%\%PAGE_NAME_LOWER%_view.dart"

echo.
echo ✅ 页面文件创建成功！
echo.
echo 下一步：
echo 1. 在 lib\routers\names.dart 添加路由常量:
echo    static const %PAGE_NAME_LOWER% = '/%PAGE_NAME_LOWER%';
echo.
echo 2. 在 lib\routers\pages.dart 注册路由:
echo    GetPage^(
echo      name: AppRoutes.%PAGE_NAME_LOWER%,
echo      page: ^(^) =^> const %PAGE_NAME%Page^(^),
echo    ^),
echo.
echo 3. 在 lib\pages\pages.dart 导出页面:
echo    export '%PAGE_NAME_LOWER%/%PAGE_NAME_LOWER%_view.dart';
echo.
echo 4. 使用路由跳转:
echo    Get.toNamed^(AppRoutes.%PAGE_NAME_LOWER%^);
