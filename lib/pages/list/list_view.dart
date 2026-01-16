/// 使用方法：Get.toNamed(AppRoutes.listDemo);
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/components/common/app_refresh_list.dart';
import 'package:tin_flutter_scafflod/components/business/list_item_card.dart';
import 'package:tin_flutter_scafflod/repository/list_repository.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

import 'list_logic.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(
      ListLogic(repository: Get.find<ListRepository>()),
    );
    final state = logic.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.listTitle),
      ),
      body: Obx(
        () {
          final isInitialLoading =
              state.isRefreshing.value && state.items.isEmpty;
          return AppRefreshList(
            controller: state.refreshController,
            onRefresh: () => logic.fetchList(isRefresh: true),
            onLoading: () => logic.fetchList(isRefresh: false),
            enablePullUp: state.hasMore.value && !state.isLoadingMore.value,
            isEmpty: state.items.isEmpty &&
                !state.hasError.value &&
                !isInitialLoading,
            hasError: state.hasError.value,
            emptyMessage: AppStrings.listEmpty,
            errorMessage: AppStrings.listError,
            child: isInitialLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.items.length,
                    itemBuilder: (_, index) {
                      final item = state.items[index];
                      return ListItemCard(
                        item: item,
                        onTap: () => Get.snackbar('点击', item.title),
                        onLongPress: () => Get.snackbar('长按', item.title),
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
