/// 使用方法：ListRemoteDataSource(apiClient: Get.find<ApiClient>());
import 'package:tin_flutter_scafflod/api/api_client.dart';
import 'package:tin_flutter_scafflod/models/list_item.dart';

/// 列表远端数据源：返回模拟列表数据。
class ListRemoteDataSource {
  ListRemoteDataSource({required this.apiClient});

  final ApiClient apiClient;

  Future<List<ListItem>> fetchList({
    required int page,
    required int pageSize,
    String? keyword,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (page > 3) return [];

    return List.generate(pageSize, (index) {
      final current = (page - 1) * pageSize + index + 1;
      final prefix = keyword != null && keyword.isNotEmpty
          ? '[$keyword] '
          : '';
      return ListItem(
        id: 'item_$current',
        title: '${prefix}商品标题 $current',
        subTitle: '${prefix}这里是副标题描述 $current',
        imageUrl: 'https://picsum.photos/seed/$current/120/120',
        status: current % 2 == 0 ? '进行中' : '已完成',
        time: '2026-01-0${(current % 9) + 1} 12:30',
        price: 99 + current.toDouble(),
        tags: ['标签A', '标签B'],
      );
    });
  }
}
