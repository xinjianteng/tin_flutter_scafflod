/// 使用方法：const AppLoading(label: '加载中...');
import 'package:flutter/material.dart';

/// 原子加载：适配页面/组件级加载状态。
class AppLoading extends StatelessWidget {
  const AppLoading({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator(),
        if (label != null) ...[
          const SizedBox(height: 8),
          Text(label!, style: theme.textTheme.bodySmall),
        ],
      ],
    );
  }
}
