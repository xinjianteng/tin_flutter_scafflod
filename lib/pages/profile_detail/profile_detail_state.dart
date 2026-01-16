/// 使用方法：final state = ProfileDetailState();
import 'package:get/get.dart';

class ProfileDetailState {
  final RxString phone = '188****8888'.obs;
  final RxString email = 'user@example.com'.obs;
  final RxString address = '深圳市南山区'.obs;
}
