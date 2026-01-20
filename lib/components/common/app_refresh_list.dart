/// 使用方法：AppRefreshList(controller: ctrl, child: list);
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tin_flutter_scafflod/components/common/app_empty.dart';

/// 通用下拉刷新列表容器。
class AppRefreshList extends StatelessWidget {
  const AppRefreshList({
    super.key,
    required this.controller,
    required this.child,
    this.onRefresh,
    this.onLoading,
    this.enablePullDown = true,
    this.enablePullUp = false,
    this.isEmpty = false,
    this.hasError = false,
    this.emptyMessage = '暂无数据',
    this.errorMessage = '加载失败，请重试',
    this.onRetry,
  });

  final RefreshController controller;
  final Widget child;
  final VoidCallback? onRefresh;
  final VoidCallback? onLoading;
  final bool enablePullDown;
  final bool enablePullUp;
  final bool isEmpty;
  final bool hasError;
  final String emptyMessage;
  final String errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    Widget content = child;
    if (hasError) {
      content = AppEmpty(
        message: errorMessage,
        icon: Icons.wifi_off_outlined,
        onRetry: onRetry ?? onRefresh,
      );
    } else if (isEmpty) {
      content = AppEmpty(
        message: emptyMessage,
        onRetry: onRetry ?? onRefresh,
      );
    }

    return SmartRefresher(
      controller: controller,
      enablePullDown: enablePullDown,
      enablePullUp: enablePullUp,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: content,
    );
  }
}
