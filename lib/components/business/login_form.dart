/// 使用方法：LoginForm(formKey: key, accountController: ctrl, onSubmit: submit);
import 'package:flutter/material.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_button.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_input.dart';
import 'package:tin_flutter_scafflod/utils/validate_util.dart';

/// 业务组件：登录表单。
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.formKey,
    required this.accountController,
    required this.passwordController,
    required this.accountFocusNode,
    required this.passwordFocusNode,
    required this.isSubmitting,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController accountController;
  final TextEditingController passwordController;
  final FocusNode accountFocusNode;
  final FocusNode passwordFocusNode;
  final bool isSubmitting;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppInput(
            controller: accountController,
            label: '手机号/邮箱',
            hintText: '请输入手机号或邮箱',
            focusNode: accountFocusNode,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => ValidateUtil.validateAccount(value ?? ''),
            onFieldSubmitted: (_) => passwordFocusNode.requestFocus(),
          ),
          const SizedBox(height: 12),
          AppInput(
            controller: passwordController,
            label: '密码',
            hintText: '请输入密码',
            focusNode: passwordFocusNode,
            obscureText: true,
            textInputAction: TextInputAction.done,
            validator: (value) => ValidateUtil.validatePassword(value ?? ''),
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
