/// 使用方法：final state = SearchState();
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/models/list_item.dart';

class SearchState {
  final TextEditingController keywordController = TextEditingController();
  final RxList<String> history = <String>[].obs;
  final RxList<ListItem> results = <ListItem>[].obs;
  final RxBool isSearching = false.obs;

  void dispose() {
    keywordController.dispose();
  }
}
