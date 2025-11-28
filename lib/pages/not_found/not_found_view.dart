import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/routers/routes.dart';
import '/values/values.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.notFoundTitle)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 12),
            const Text(AppStrings.notFoundMessage),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.application),
              child: const Text(AppStrings.backToHome),
            ),
          ],
        ),
      ),
    );
  }
}
