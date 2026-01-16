/// 使用方法：Get.put(FeedbackLogic());
import 'package:get/get.dart';

import 'feedback_state.dart';

class FeedbackLogic extends GetxController {
  final FeedbackState state = FeedbackState();

  void submit() {
    final isValid = state.formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    Get.snackbar('提交成功', '感谢反馈，我们会尽快处理');
    state.contentController.clear();
    state.contactController.clear();
  }

  @override
  void onClose() {
    state.dispose();
    super.onClose();
  }
}
