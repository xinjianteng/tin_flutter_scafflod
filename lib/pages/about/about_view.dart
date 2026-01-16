/// 使用方法：Get.toNamed(AppRoutes.aboutApp);
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final website = Uri.parse('https://example.com');
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
            Text(AppStrings.appTagline, style: theme.textTheme.bodyLarge),
            const SizedBox(height: 16),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(AppStrings.aboutWebsite),
              trailing: const Icon(Icons.open_in_new),
              onTap: () async {
                await launchUrl(
                  website,
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(AppStrings.aboutAgreement),
              trailing: const Icon(Icons.description_outlined),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(AppStrings.aboutPrivacy),
              trailing: const Icon(Icons.privacy_tip_outlined),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
