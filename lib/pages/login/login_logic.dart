/// 使用方法：Get.put(LoginLogic(authService: ..., authRepository: ...));
import 'dart:async';

import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/repository/auth_repository.dart';
import 'package:tin_flutter_scafflod/routers/routes.dart';
import 'package:tin_flutter_scafflod/service/oauth_service.dart';
import 'package:tin_flutter_scafflod/utils/validate_util.dart';

import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final OauthService authService;
  final AuthRepository authRepository;
  Timer? _timer;

  LoginLogic({
    required this.authService,
    required this.authRepository,
  });

  Future<void> sendCode() async {
    final phone = state.phoneController.text.trim();
    final phoneError = ValidateUtil.validatePhone(phone);
    if (phoneError != null) {
      state.phoneFocusNode.requestFocus();
      state.formKey.currentState?.validate();
      return;
    }

    if (state.countdownSeconds.value > 0) return;

    final success = await authRepository.requestSmsCode(phone: phone);
    if (success) {
      _startCountdown();
    } else {
      Get.snackbar('发送失败', '请稍后重试');
    }
  }

  Future<void> submit() async {
    if (state.isSubmitting.value) return;

    final phone = state.phoneController.text.trim();
    final code = state.codeController.text.trim();
    final isValid = state.formKey.currentState?.validate() ?? false;
    if (!isValid) {
      if (ValidateUtil.validatePhone(phone) != null) {
        state.phoneFocusNode.requestFocus();
      } else if (ValidateUtil.validateSmsCode(code) != null) {
        state.codeFocusNode.requestFocus();
      }
      return;
    }

    state.isSubmitting.value = true;
    try {
      final oauth = await authRepository.loginWithSms(
        phone: phone,
        code: code,
      );
      await authService.login(oauth);
      Get.offAllNamed(AppRoutes.application);
    } catch (e) {
      Get.snackbar('登录失败', e.toString());
    } finally {
      state.isSubmitting.value = false;
    }
  }

  void _startCountdown() {
    _timer?.cancel();
    state.countdownSeconds.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final next = state.countdownSeconds.value - 1;
      state.countdownSeconds.value = next;
      if (next <= 0) {
        timer.cancel();
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    state.dispose();
    super.onClose();
  }
}
