library;

/// 使用方法：Get.put(RegisterLogic(authRepository: Get.find<AuthRepository>()));
import 'dart:async';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/repository/auth_repository.dart';
import 'package:tin_flutter_scafflod/routers/names.dart';
import 'package:tin_flutter_scafflod/service/oauth_service.dart';
import 'package:tin_flutter_scafflod/utils/validate_util.dart';
import 'register_state.dart';

class RegisterLogic extends GetxController {
  RegisterLogic({required this.authRepository});

  final AuthRepository authRepository;
  final RegisterState state = RegisterState();
  Timer? _countdownTimer;

  @override
  void onClose() {
    state.dispose();
    _countdownTimer?.cancel();
    super.onClose();
  }

  Future<void> requestSmsCode() async {
    final phone = state.phoneController.text.trim();
    if (!ValidateUtil.isPhone(phone)) {
      Get.snackbar('提示', '请输入正确的手机号');
      return;
    }

    if (state.countdownSeconds.value > 0) return;

    try {
      final success = await authRepository.requestSmsCode(phone: phone);
      if (success) {
        Get.snackbar('成功', '验证码已发送');
        _startCountdown();
      } else {
        Get.snackbar('失败', '验证码发送失败');
      }
    } catch (e) {
      Get.snackbar('错误', '验证码发送失败: $e');
    }
  }

  void _startCountdown() {
    state.countdownSeconds.value = 60;
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdownSeconds.value > 0) {
        state.countdownSeconds.value--;
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> register() async {
    if (!state.formKey.currentState!.validate()) return;

    final phone = state.phoneController.text.trim();
    final code = state.codeController.text.trim();
    final password = state.passwordController.text.trim();
    final confirmPassword = state.confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      Get.snackbar('提示', '两次输入的密码不一致');
      return;
    }

    state.isSubmitting.value = true;
    try {
      final oauth = await authRepository.loginWithSms(phone: phone, code: code);
      final authService = Get.find<OauthService>();
      await authService.login(oauth);
      Get.offAllNamed(AppRoutes.application);
    } catch (e) {
      Get.snackbar('注册失败', e.toString());
    } finally {
      state.isSubmitting.value = false;
    }
  }
}
