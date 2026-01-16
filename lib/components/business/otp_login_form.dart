/// 使用方法：OtpLoginForm(state: state, onSubmit: submit, onSendCode: send);
import 'package:flutter/material.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_button.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_input.dart';
import 'package:tin_flutter_scafflod/utils/validate_util.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

/// 业务组件：手机号验证码登录表单。
class OtpLoginForm extends StatelessWidget {
  const OtpLoginForm({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.codeController,
    required this.phoneFocusNode,
    required this.codeFocusNode,
    required this.isSubmitting,
    required this.countdownSeconds,
    required this.onSendCode,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final TextEditingController codeController;
  final FocusNode phoneFocusNode;
  final FocusNode codeFocusNode;
  final bool isSubmitting;
  final int countdownSeconds;
  final VoidCallback onSendCode;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final sendLabel = countdownSeconds > 0
        ? '${countdownSeconds}s'
        : AppStrings.loginSendCode;
    final sendDisabled = countdownSeconds > 0;

    return Form(
      key: formKey,
      child: Column(
        children: [
          AppInput(
            controller: phoneController,
            label: '手机号',
            hintText: '请输入手机号',
            focusNode: phoneFocusNode,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidateUtil.validatePhone(value ?? ''),
            onFieldSubmitted: (_) => codeFocusNode.requestFocus(),
          ),
          const SizedBox(height: 12),
          AppInput(
            controller: codeController,
            label: '验证码',
            hintText: '请输入验证码',
            focusNode: codeFocusNode,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            validator: (value) => ValidateUtil.validateSmsCode(value ?? ''),
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextButton(
                onPressed: sendDisabled ? null : onSendCode,
                child: Text(sendLabel),
              ),
            ),
            onFieldSubmitted: (_) => onSubmit(),
          ),
          const SizedBox(height: 20),
          AppButton(
            label: '登录',
            isLoading: isSubmitting,
            onPressed: onSubmit,
          ),
        ],
      ),
    );
  }
}
