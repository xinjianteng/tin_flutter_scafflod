/// 使用方法：AppEmpty(message: '暂无数据', onRetry: retry);
import 'package:flutter/material.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_button.dart';

/// 通用空状态/错误状态占位。
class AppEmpty extends StatelessWidget {
  const AppEmpty({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.onRetry,
  });

  final String message;
  final IconData icon;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: theme.disabledColor),
            const SizedBox(height: 12),
            Text(message, style: theme.textTheme.bodyMedium),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              AppButton(
                label: '重试',
                onPressed: onRetry,
                fullWidth: false,
                style: AppButtonStyle.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
