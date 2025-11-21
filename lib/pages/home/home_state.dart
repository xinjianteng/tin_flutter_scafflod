import 'package:get/get.dart';

class HomeState {
  final List<Map<String, String>> quickActions = [
    {'title': '快速开始', 'desc': '查看项目结构'},
    {'title': '新建模块', 'desc': '按领域划分功能'},
    {'title': '调试工具', 'desc': '日志、缓存与网络'},
    {'title': '主题配置', 'desc': '统一色彩与字号'},
  ];

  final RxBool isBusy = false.obs;
}
