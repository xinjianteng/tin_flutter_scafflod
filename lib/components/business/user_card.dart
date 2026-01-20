/// 使用方法：UserCard(displayName: '张三', statusLabel: '已登录');
import 'package:flutter/material.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_button.dart';

/// 业务组件：用户信息卡片。
class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.displayName,
    required this.statusLabel,
    required this.actionLabel,
    required this.onAction,
  });

  final String displayName;
  final String statusLabel;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
                  child: const Icon(Icons.person_outline),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(displayName, style: theme.textTheme.titleMedium),
                    Text(statusLabel, style: theme.textTheme.bodySmall),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppButton(label: actionLabel, onPressed: onAction),
          ],
        ),
      ),
    );
  }
}
