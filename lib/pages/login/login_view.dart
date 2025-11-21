import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/service/oauth_service.dart';
import '/values/values.dart';

import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(LoginLogic(authService: Get.find<OauthService>()));
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.login),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '快速登录模板',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              '在这里替换为实际的登录表单逻辑，当前按钮会直接写入模拟 OAuth。',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: logic.mockLogin,
                child: const Text('模拟登录'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
