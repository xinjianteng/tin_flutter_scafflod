library;

/// 使用方法：final state = ArticleDetailState();
import 'package:get/get.dart';

class Article {
  final String id;
  final String title;
  final String author;
  final String publishTime;
  final String content;
  final String? coverImage;
  final int viewCount;
  final int likeCount;
  final bool isLiked;

  Article({
    required this.id,
    required this.title,
    required this.author,
    required this.publishTime,
    required this.content,
    this.coverImage,
    this.viewCount = 0,
    this.likeCount = 0,
    this.isLiked = false,
  });
}

class ArticleDetailState {
  final Rx<Article?> article = Rx<Article?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isLiked = false.obs;
  final RxInt likeCount = 0.obs;
}
