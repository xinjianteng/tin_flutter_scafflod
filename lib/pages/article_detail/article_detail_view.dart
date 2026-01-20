library;

/// 使用方法：Get.toNamed(AppRoutes.articleDetail, parameters: {'id': '123'});
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'article_detail_logic.dart';

class ArticleDetailPage extends StatelessWidget {
  const ArticleDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ArticleDetailLogic());
    final state = logic.state;
    final theme = Theme.of(context);

    return Scaffold(
      body: Obx(() {
        if (state.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final article = state.article.value;
        if (article == null) {
          return const Center(child: Text('文章不存在'));
        }

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.h,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                background: article.coverImage != null
                    ? CachedNetworkImage(
                        imageUrl: article.coverImage!,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        color: theme.colorScheme.primaryContainer,
                      ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: logic.share,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20.r,
                          child: Text(article.author[0]),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.author,
                                style: theme.textTheme.titleMedium,
                              ),
                              Text(
                                article.publishTime,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.visibility,
                              size: 16.sp,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.6),
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${article.viewCount}',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface
                                    .withValues(alpha: 0.6),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      article.content,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.8,
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
          child: Row(
            children: [
              Obx(() => IconButton(
                    icon: Icon(
                      state.isLiked.value
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: state.isLiked.value ? Colors.red : null,
                    ),
                    onPressed: logic.toggleLike,
                  )),
              Obx(() => Text('${state.likeCount.value}')),
              SizedBox(width: 16.w),
              IconButton(
                icon: const Icon(Icons.comment_outlined),
                onPressed: () {
                  Get.snackbar('提示', '评论功能开发中');
                },
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.bookmark_border),
                onPressed: () {
                  Get.snackbar('提示', '收藏功能开发中');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
