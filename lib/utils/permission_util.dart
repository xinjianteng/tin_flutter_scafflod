import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tin_flutter_scafflod/utils/platform_util.dart';

/// 权限管理工具
class PermissionUtil {
  /// 请求单个权限
  static Future<bool> request(Permission permission) async {
    if (PlatformUtil.isWeb) return true;

    final status = await permission.request();
    return status.isGranted;
  }

  /// 请求多个权限
  static Future<Map<Permission, bool>> requestMultiple(
    List<Permission> permissions,
  ) async {
    if (PlatformUtil.isWeb) {
      return {for (var p in permissions) p: true};
    }

    final statuses = await permissions.request();
    return statuses.map((key, value) => MapEntry(key, value.isGranted));
  }

  /// 检查权限状态
  static Future<bool> check(Permission permission) async {
    if (PlatformUtil.isWeb) return true;
    return await permission.isGranted;
  }

  /// 打开应用设置
  static Future<void> openSettings() async {
    if (!PlatformUtil.isWeb) {
      await openAppSettings();
    }
  }

  /// 请求权限（带提示对话框）
  static Future<bool> requestWithDialog({
    required Permission permission,
    required String title,
    required String message,
  }) async {
    if (PlatformUtil.isWeb) return true;

    final status = await permission.status;

    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      return await _showSettingsDialog(title, message);
    }

    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('授权'),
          ),
        ],
      ),
    );

    if (result == true) {
      return await request(permission);
    }

    return false;
  }

  static Future<bool> _showSettingsDialog(String title, String message) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text('$message\n\n请在设置中手动开启权限'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text('去设置'),
          ),
        ],
      ),
    );

    if (result == true) {
      await openSettings();
    }

    return false;
  }

  /// 常用权限快捷方法
  static Future<bool> requestCamera() => requestWithDialog(
        permission: Permission.camera,
        title: '相机权限',
        message: '需要访问相机以拍摄照片',
      );

  static Future<bool> requestPhotos() => requestWithDialog(
        permission: Permission.photos,
        title: '相册权限',
        message: '需要访问相册以选择照片',
      );

  static Future<bool> requestLocation() => requestWithDialog(
        permission: Permission.location,
        title: '定位权限',
        message: '需要访问位置信息',
      );

  static Future<bool> requestStorage() => requestWithDialog(
        permission: Permission.storage,
        title: '存储权限',
        message: '需要访问存储以保存文件',
      );

  static Future<bool> requestMicrophone() => requestWithDialog(
        permission: Permission.microphone,
        title: '麦克风权限',
        message: '需要访问麦克风以录音',
      );

  static Future<bool> requestNotification() => requestWithDialog(
        permission: Permission.notification,
        title: '通知权限',
        message: '需要发送通知以提醒您',
      );
}
