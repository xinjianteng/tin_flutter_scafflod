library;

/// 使用方法：Get.put(NotificationLogic());
import 'package:get/get.dart';
import 'notification_state.dart';

class NotificationLogic extends GetxController {
  final NotificationState state = NotificationState();

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  @override
  void onClose() {
    state.refreshController.dispose();
    super.onClose();
  }

  Future<void> loadNotifications() async {
    state.isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      final mockData = [
        NotificationItem(
          id: '1',
          title: '系统通知',
          content: '您的账号已成功注册，欢迎使用！',
          time: '2小时前',
          type: 'system',
          isRead: false,
        ),
        NotificationItem(
          id: '2',
          title: '活动提醒',
          content: '新春特惠活动即将开始，敬请期待',
          time: '5小时前',
          type: 'activity',
          isRead: false,
        ),
        NotificationItem(
          id: '3',
          title: '版本更新',
          content: '发现新版本 v2.0.0，建议立即更新',
          time: '1天前',
          type: 'update',
          isRead: true,
        ),
        NotificationItem(
          id: '4',
          title: '安全提醒',
          content: '检测到您的账号在新设备登录',
          time: '2天前',
          type: 'security',
          isRead: true,
        ),
        NotificationItem(
          id: '5',
          title: '功能推荐',
          content: '试试新功能：智能推荐，为您精选优质内容',
          time: '3天前',
          type: 'feature',
          isRead: true,
        ),
      ];

      state.notifications.assignAll(mockData);
      _updateUnreadCount();
    } catch (e) {
      Get.snackbar('错误', '加载通知失败: $e');
    } finally {
      state.isLoading.value = false;
    }
  }

  Future<void> onRefresh() async {
    await loadNotifications();
    state.refreshController.refreshCompleted();
  }

  void markAsRead(String id) {
    final index = state.notifications.indexWhere((item) => item.id == id);
    if (index != -1) {
      final item = state.notifications[index];
      state.notifications[index] = NotificationItem(
        id: item.id,
        title: item.title,
        content: item.content,
        time: item.time,
        type: item.type,
        isRead: true,
      );
      _updateUnreadCount();
    }
  }

  void markAllAsRead() {
    state.notifications.value = state.notifications.map((item) {
      return NotificationItem(
        id: item.id,
        title: item.title,
        content: item.content,
        time: item.time,
        type: item.type,
        isRead: true,
      );
    }).toList();
    _updateUnreadCount();
    Get.snackbar('提示', '已全部标记为已读');
  }

  void deleteNotification(String id) {
    state.notifications.removeWhere((item) => item.id == id);
    _updateUnreadCount();
    Get.snackbar('提示', '已删除');
  }

  void _updateUnreadCount() {
    state.unreadCount.value =
        state.notifications.where((item) => !item.isRead).length;
  }
}
