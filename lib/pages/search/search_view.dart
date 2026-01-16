/// 使用方法：Get.toNamed(AppRoutes.search);
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/components/business/list_item_card.dart';
import 'package:tin_flutter_scafflod/repository/list_repository.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

import 'search_logic.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(
      SearchLogic(repository: Get.find<ListRepository>()),
    );
    final state = logic.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.search),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: state.keywordController,
                decoration: InputDecoration(
                  hintText: AppStrings.searchHint,
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSubmitted: logic.search,
              ),
              const SizedBox(height: 12),
              if (state.history.isNotEmpty) ...[
                Text(AppStrings.searchHistory,
                    style: theme.textTheme.titleSmall),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: state.history
                      .map(
                        (item) => ActionChip(
                          label: Text(item),
                          onPressed: () {
                            state.keywordController.text = item;
                            logic.search(item);
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 12),
              ],
              Text(AppStrings.searchResult, style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              Expanded(
                child: state.isSearching.value
                    ? const Center(child: CircularProgressIndicator())
                    : state.results.isEmpty
                        ? Center(
                            child: Text(
                              AppStrings.searchEmpty,
                              style: theme.textTheme.bodyMedium,
                            ),
                          )
                        : ListView.builder(
                            itemCount: state.results.length,
                            itemBuilder: (_, index) {
                              final item = state.results[index];
                              return ListItemCard(
                                item: item,
                                onTap: () =>
                                    Get.snackbar('搜索结果', item.title),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
