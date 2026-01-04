import 'package:flutter/material.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.about),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.appName, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('版本：${AppStrings.appVersion}',
                style: theme.textTheme.bodyMedium),
            Text('作者：${AppStrings.appAuthor}',
                style: theme.textTheme.bodyMedium),
            const SizedBox(height: 16),
            Text(
              AppStrings.appTagline,
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
