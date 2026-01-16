/// 使用方法：ListItem(title: '标题', subTitle: '副标题');
class ListItem {
  ListItem({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.status,
    required this.time,
    required this.price,
    required this.tags,
  });

  final String id;
  final String title;
  final String subTitle;
  final String imageUrl;
  final String status;
  final String time;
  final double price;
  final List<String> tags;
}
