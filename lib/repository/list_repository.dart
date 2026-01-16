/// 使用方法：ListRepository(remote: Get.find<ListRemoteDataSource>());
import 'package:tin_flutter_scafflod/datasource/list_remote_data_source.dart';
import 'package:tin_flutter_scafflod/models/list_item.dart';

/// 列表仓库：封装列表数据获取。
class ListRepository {
  ListRepository({required this.remote});

  final ListRemoteDataSource remote;

  Future<List<ListItem>> fetchList({
    required int page,
    required int pageSize,
    String? keyword,
  }) {
    return remote.fetchList(
      page: page,
      pageSize: pageSize,
      keyword: keyword,
    );
  }
}
