/// 使用方法：final state = ListState();
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tin_flutter_scafflod/models/list_item.dart';

class ListState {
  final RefreshController refreshController = RefreshController();
  final RxList<ListItem> items = <ListItem>[].obs;
  final RxBool isRefreshing = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasError = false.obs;
  final RxBool hasMore = true.obs;
  int page = 1;
}
