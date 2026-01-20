library;

/// 使用方法：Get.put(ComponentShowcaseLogic());
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'component_showcase_state.dart';

class ComponentShowcaseLogic extends GetxController {
  final ComponentShowcaseState state = ComponentShowcaseState();

  @override
  void onClose() {
    state.dispose();
    super.onClose();
  }

  void showLoadingDemo() {
    state.isLoading.value = true;
    Future.delayed(const Duration(seconds: 2), () {
      state.isLoading.value = false;
      Get.snackbar('提示', '加载完成');
    });
  }

  void showDialogDemo() {
    Get.dialog(
      AlertDialog(
        title: const Text('对话框示例'),
        content: const Text('这是一个对话框组件的示例'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              Get.snackbar('提示', '已确认');
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }

  void showBottomSheetDemo() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '底部弹窗示例',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('这是一个底部弹窗组件的示例'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text('关闭'),
            ),
          ],
        ),
      ),
    );
  }
}
