import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/service/oauth_service.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

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
              AppStrings.loginTitle,
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.loginTip,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: logic.mockLogin,
                child: const Text(AppStrings.mockLogin),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
