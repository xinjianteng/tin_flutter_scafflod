import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'failures.dart';

/// 全局错误处理器
class ErrorHandler {
  /// 处理错误并返回 Failure
  static Failure handleError(dynamic error) {
    if (error is SocketException) {
      return NetworkFailure(
        message: '网络连接失败，请检查网络设置',
        code: 'NETWORK_ERROR',
        originalError: error,
      );
    } else if (error is HttpException) {
      return ServerFailure(
        message: '服务器错误，请稍后重试',
        code: 'SERVER_ERROR',
        originalError: error,
      );
    } else if (error is FormatException) {
      return ServerFailure(
        message: '数据格式错误',
        code: 'FORMAT_ERROR',
        originalError: error,
      );
    } else if (error is Failure) {
      return error;
    } else {
      return UnknownFailure(
        message: '未知错误: ${error.toString()}',
        code: 'UNKNOWN_ERROR',
        originalError: error,
      );
    }
  }

  /// 显示错误消息
  static void showError(Failure failure, {bool useSnackbar = true}) {
    if (useSnackbar) {
      Get.snackbar(
        '错误',
        failure.message,
        snackPosition: SnackPosition.bottom,
      );
    } else {
      Get.dialog(
        AlertDialog(
          title: const Text('错误'),
          content: Text(failure.message),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('确定'),
            ),
          ],
        ),
      );
    }
  }

  /// 获取用户友好的错误消息
  static String getUserFriendlyMessage(Failure failure) {
    if (failure is NetworkFailure) {
      return '网络连接失败，请检查网络设置';
    } else if (failure is ServerFailure) {
      return '服务器繁忙，请稍后重试';
    } else if (failure is ValidationFailure) {
      return failure.message;
    } else if (failure is PermissionFailure) {
      return '权限不足，请授予必要的权限';
    } else {
      return '操作失败，请重试';
    }
  }
}
