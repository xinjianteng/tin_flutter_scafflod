/// 使用方法：Get.toNamed(AppRoutes.login);
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/components/business/otp_login_form.dart';
import 'package:tin_flutter_scafflod/repository/auth_repository.dart';
import 'package:tin_flutter_scafflod/routers/names.dart';
import 'package:tin_flutter_scafflod/service/oauth_service.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(
      LoginLogic(
        authService: Get.find<OauthService>(),
        authRepository: Get.find<AuthRepository>(),
      ),
    );
    final state = logic.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.loginTitle,
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                AppStrings.loginTip,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              Obx(
                () => OtpLoginForm(
                  formKey: state.formKey,
                  phoneController: state.phoneController,
                  codeController: state.codeController,
                  phoneFocusNode: state.phoneFocusNode,
                  codeFocusNode: state.codeFocusNode,
                  isSubmitting: state.isSubmitting.value,
                  countdownSeconds: state.countdownSeconds.value,
                  onSendCode: logic.sendCode,
                  onSubmit: logic.submit,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '还没有账号？',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed(AppRoutes.register),
                    child: const Text('立即注册'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
