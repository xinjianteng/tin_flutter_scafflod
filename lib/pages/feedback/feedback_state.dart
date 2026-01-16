/// 使用方法：final state = FeedbackState();
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final RxString selectedCategory = '功能异常'.obs;
  final List<String> categories = const [
    '功能异常',
    '体验建议',
    '内容问题',
    '其他',
  ];

  void dispose() {
    contentController.dispose();
    contactController.dispose();
  }
}
