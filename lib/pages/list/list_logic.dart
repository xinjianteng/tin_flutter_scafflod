/// 使用方法：Get.put(ListLogic(repository: Get.find<ListRepository>()));
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/repository/list_repository.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

import 'list_state.dart';

class ListLogic extends GetxController {
  ListLogic({required this.repository});

  final ListRepository repository;
  final ListState state = ListState();

  @override
  void onInit() {
    super.onInit();
    fetchList(isRefresh: true);
  }

  Future<void> fetchList({required bool isRefresh}) async {
    if (isRefresh) {
      if (state.isRefreshing.value) return;
      state.isRefreshing.value = true;
      state.page = 1;
    } else {
      if (state.isLoadingMore.value || !state.hasMore.value) return;
      state.isLoadingMore.value = true;
    }

    state.hasError.value = false;

    try {
      final list = await repository.fetchList(
        page: state.page,
        pageSize: AppConstants.pageSize,
      );

      if (isRefresh) {
        state.items.assignAll(list);
        state.refreshController.refreshCompleted();
      } else {
        state.items.addAll(list);
        state.refreshController.loadComplete();
      }

      state.hasMore.value = list.length >= AppConstants.pageSize;
      if (state.hasMore.value) {
        state.page += 1;
        state.refreshController.resetNoData();
      } else {
        state.refreshController.loadNoData();
      }
    } catch (_) {
      state.hasError.value = true;
      if (isRefresh) {
        state.refreshController.refreshFailed();
      } else {
        state.refreshController.loadFailed();
      }
    } finally {
      if (isRefresh) {
        state.isRefreshing.value = false;
      } else {
        state.isLoadingMore.value = false;
      }
    }
  }

  @override
  void onClose() {
    state.refreshController.dispose();
    super.onClose();
  }
}
