/// 使用方法：final state = LoginState();
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginState {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final FocusNode phoneFocusNode = FocusNode();
  final FocusNode codeFocusNode = FocusNode();
  final RxBool isSubmitting = false.obs;
  final RxInt countdownSeconds = 0.obs;

  void dispose() {
    phoneController.dispose();
    codeController.dispose();
    phoneFocusNode.dispose();
    codeFocusNode.dispose();
  }
}
