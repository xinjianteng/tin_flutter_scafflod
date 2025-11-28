import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/values/values.dart';

import 'home_logic.dart';
import 'home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeLogic logic = Get.put(HomeLogic());
    final HomeState state = logic.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: RefreshIndicator(
        onRefresh: logic.mockFetch,
        child: Obx(
          () => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildHeader(theme),
              const SizedBox(height: 12),
              _buildPlatformCard(theme, state),
              const SizedBox(height: 12),
              ...state.quickActions.map(
                (item) => _ActionCard(
                  action: item,
                  onTap: logic.mockFetch,
                ),
              ),
              const SizedBox(height: 20),
              if (state.isBusy.value)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.scaffoldIntroTitle,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            AppStrings.appTagline,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildPlatformCard(ThemeData theme, HomeState state) {
    return Card(
      margin: const EdgeInsets.only(top: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.platformGuideTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              AppStrings.platformGuideDesc,
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            ...state.platformGuides.map(
              (item) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  item.supported
                      ? Icons.check_circle_outline
                      : Icons.info_outline,
                  color: item.supported
                      ? theme.colorScheme.primary
                      : theme.disabledColor,
                ),
                title: Text(item.title),
                subtitle: Text(item.note),
                trailing: Text(
                  item.supported ? '当前可用' : '当前不可用',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: item.supported
                        ? theme.colorScheme.primary
                        : theme.colorScheme.error,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard({
    required this.action,
    required this.onTap,
  });

  final HomeAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        leading: Icon(action.icon, color: theme.colorScheme.primary),
        title: Text(action.title),
        subtitle: Text(action.description),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
        minLeadingWidth: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
