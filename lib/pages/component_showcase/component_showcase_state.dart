library;

/// 使用方法：final state = ComponentShowcaseState();
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComponentShowcaseState {
  final TextEditingController inputController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString selectedTab = 'atoms'.obs;

  void dispose() {
    inputController.dispose();
    searchController.dispose();
  }
}
