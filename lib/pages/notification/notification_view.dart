library;

/// 使用方法：Get.toNamed(AppRoutes.notification);
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'notification_logic.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(NotificationLogic());
    final state = logic.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final unread = state.unreadCount.value;
          return Text(unread > 0 ? '通知 ($unread)' : '通知');
        }),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'markAll') {
                logic.markAllAsRead();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'markAll',
                child: Text('全部标记为已读'),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (state.isLoading.value && state.notifications.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.notifications.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.notifications_none,
                  size: 80.sp,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                ),
                SizedBox(height: 16.h),
                Text(
                  '暂无通知',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          );
        }

        return SmartRefresher(
          controller: state.refreshController,
          onRefresh: logic.onRefresh,
          child: ListView.separated(
            itemCount: state.notifications.length,
            separatorBuilder: (_, __) => Divider(height: 1.h),
            itemBuilder: (context, index) {
              final item = state.notifications[index];
              return Dismissible(
                key: Key(item.id),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 16.w),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) => logic.deleteNotification(item.id),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item.isRead
                        ? theme.colorScheme.surfaceContainerHighest
                        : theme.colorScheme.primaryContainer,
                    child: Icon(
                      _getIconByType(item.type),
                      color: item.isRead
                          ? theme.colorScheme.onSurface
                          : theme.colorScheme.primary,
                    ),
                  ),
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: item.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!item.isRead)
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h),
                      Text(
                        item.content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        item.time,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (!item.isRead) {
                      logic.markAsRead(item.id);
                    }
                    Get.snackbar('通知详情', item.content);
                  },
                ),
              );
            },
          ),
        );
      }),
    );
  }

  IconData _getIconByType(String type) {
    switch (type) {
      case 'system':
        return Icons.info_outline;
      case 'activity':
        return Icons.campaign_outlined;
      case 'update':
        return Icons.system_update_outlined;
      case 'security':
        return Icons.security_outlined;
      case 'feature':
        return Icons.star_outline;
      default:
        return Icons.notifications_outlined;
    }
  }
}
