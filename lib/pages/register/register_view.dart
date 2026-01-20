library;

/// 使用方法：Get.toNamed(AppRoutes.register);
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_button.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_input.dart';
import 'package:tin_flutter_scafflod/repository/auth_repository.dart';
import 'package:tin_flutter_scafflod/utils/validate_util.dart';
import 'register_logic.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(
      RegisterLogic(authRepository: Get.find<AuthRepository>()),
    );
    final state = logic.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('注册'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Form(
            key: state.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 20.h),
                Text(
                  '创建新账号',
                  style: theme.textTheme.headlineMedium,
                ),
                SizedBox(height: 8.h),
                Text(
                  '请填写以下信息完成注册',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                SizedBox(height: 40.h),
                AppInput(
                  controller: state.phoneController,
                  focusNode: state.phoneFocusNode,
                  label: '手机号',
                  hintText: '请输入手机号',
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '请输入手机号';
                    }
                    if (!ValidateUtil.isPhone(value)) {
                      return '请输入正确的手机号';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: AppInput(
                        controller: state.codeController,
                        focusNode: state.codeFocusNode,
                        label: '验证码',
                        hintText: '请输入验证码',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '请输入验证码';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Obx(() {
                      final countdown = state.countdownSeconds.value;
                      return SizedBox(
                        width: 100.w,
                        child: AppButton(
                          label: countdown > 0 ? '$countdown秒' : '获取验证码',
                          onPressed: countdown > 0 ? null : logic.requestSmsCode,
                          style: AppButtonStyle.secondary,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 16.h),
                Obx(() => AppInput(
                      controller: state.passwordController,
                      focusNode: state.passwordFocusNode,
                      label: '密码',
                      hintText: '请输入密码（6-20位）',
                      obscureText: state.obscurePassword.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.obscurePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          state.obscurePassword.value =
                              !state.obscurePassword.value;
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请输入密码';
                        }
                        if (value.length < 6 || value.length > 20) {
                          return '密码长度为6-20位';
                        }
                        return null;
                      },
                    )),
                SizedBox(height: 16.h),
                Obx(() => AppInput(
                      controller: state.confirmPasswordController,
                      focusNode: state.confirmPasswordFocusNode,
                      label: '确认密码',
                      hintText: '请再次输入密码',
                      obscureText: state.obscureConfirmPassword.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          state.obscureConfirmPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          state.obscureConfirmPassword.value =
                              !state.obscureConfirmPassword.value;
                        },
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '请再次输入密码';
                        }
                        if (value != state.passwordController.text) {
                          return '两次输入的密码不一致';
                        }
                        return null;
                      },
                    )),
                SizedBox(height: 32.h),
                Obx(() => AppButton(
                      label: '注册',
                      onPressed: state.isSubmitting.value ? null : logic.register,
                      isLoading: state.isSubmitting.value,
                    )),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '已有账号？',
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('立即登录'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
