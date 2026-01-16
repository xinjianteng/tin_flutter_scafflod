/// 使用方法：Get.put(SearchLogic(repository: Get.find<ListRepository>()));
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/repository/list_repository.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

import 'search_state.dart';

class SearchLogic extends GetxController {
  SearchLogic({required this.repository});

  final ListRepository repository;
  final SearchState state = SearchState();

  Future<void> search(String keyword) async {
    final query = keyword.trim();
    if (query.isEmpty) return;
    state.isSearching.value = true;
    if (!state.history.contains(query)) {
      state.history.insert(0, query);
    }
    try {
      final list = await repository.fetchList(
        page: 1,
        pageSize: AppConstants.pageSize,
        keyword: query,
      );
      state.results.assignAll(list);
    } finally {
      state.isSearching.value = false;
    }
  }

  @override
  void onClose() {
    state.dispose();
    super.onClose();
  }
}
