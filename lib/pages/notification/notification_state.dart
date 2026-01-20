library;

/// 使用方法：final state = NotificationState();
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NotificationItem {
  final String id;
  final String title;
  final String content;
  final String time;
  final String type;
  final bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

class NotificationState {
  final RxList<NotificationItem> notifications = <NotificationItem>[].obs;
  final RxBool isLoading = false.obs;
  final RefreshController refreshController = RefreshController();
  final RxInt unreadCount = 0.obs;
}
