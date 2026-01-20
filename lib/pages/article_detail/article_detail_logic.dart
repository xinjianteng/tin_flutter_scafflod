library;

/// 使用方法：Get.put(ArticleDetailLogic());
import 'package:get/get.dart';
import 'article_detail_state.dart';

class ArticleDetailLogic extends GetxController {
  final ArticleDetailState state = ArticleDetailState();

  @override
  void onInit() {
    super.onInit();
    final articleId = Get.parameters['id'] ?? '';
    loadArticle(articleId);
  }

  Future<void> loadArticle(String articleId) async {
    state.isLoading.value = true;
    try {
      await Future.delayed(const Duration(milliseconds: 800));

      final article = Article(
        id: articleId,
        title: 'Flutter 跨平台开发最佳实践',
        author: '技术团队',
        publishTime: '2024-01-15 10:30',
        content: '''
Flutter 是 Google 推出的跨平台 UI 框架，支持 iOS、Android、Web、桌面等多个平台。

## 核心优势

1. **高性能渲染**：使用 Skia 图形引擎，直接绘制 UI
2. **热重载**：快速迭代开发，提升开发效率
3. **丰富的组件库**：Material 和 Cupertino 风格组件
4. **统一代码库**：一套代码多端运行

## 开发建议

- 合理使用状态管理（GetX、Provider、Riverpod）
- 注意性能优化，避免不必要的 Widget 重建
- 遵循 Flutter 的设计规范和最佳实践
- 做好跨平台适配和测试

## 总结

Flutter 为跨平台开发提供了优秀的解决方案，值得深入学习和应用。
        ''',
        coverImage: 'https://picsum.photos/800/400',
        viewCount: 1234,
        likeCount: 89,
        isLiked: false,
      );

      state.article.value = article;
      state.isLiked.value = article.isLiked;
      state.likeCount.value = article.likeCount;
    } catch (e) {
      Get.snackbar('错误', '加载文章失败: $e');
    } finally {
      state.isLoading.value = false;
    }
  }

  void toggleLike() {
    state.isLiked.value = !state.isLiked.value;
    state.likeCount.value += state.isLiked.value ? 1 : -1;
    Get.snackbar('提示', state.isLiked.value ? '已点赞' : '已取消点赞');
  }

  void share() {
    Get.snackbar('提示', '分享功能开发中');
  }
}
