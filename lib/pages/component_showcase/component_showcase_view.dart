library;

/// 使用方法：Get.toNamed(AppRoutes.componentShowcase);
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_button.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_input.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_loading.dart';
import 'package:tin_flutter_scafflod/components/atoms/app_text.dart';
import 'package:tin_flutter_scafflod/components/common/app_empty.dart';
import 'component_showcase_logic.dart';

class ComponentShowcasePage extends StatelessWidget {
  const ComponentShowcasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ComponentShowcaseLogic());
    final state = logic.state;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('组件展示'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('原子组件 (Atoms)', theme),
            SizedBox(height: 16.h),
            _buildAtomComponents(logic, state, theme),
            SizedBox(height: 32.h),
            _buildSectionTitle('通用组件 (Common)', theme),
            SizedBox(height: 16.h),
            _buildCommonComponents(logic, state, theme),
            SizedBox(height: 32.h),
            _buildSectionTitle('交互示例', theme),
            SizedBox(height: 16.h),
            _buildInteractionExamples(logic, state, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildAtomComponents(
    ComponentShowcaseLogic logic,
    state,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentCard(
          title: 'AppButton - 按钮组件',
          theme: theme,
          child: Column(
            children: [
              AppButton(
                label: '主要按钮',
                onPressed: () => Get.snackbar('提示', '点击了主要按钮'),
                style: AppButtonStyle.primary,
              ),
              SizedBox(height: 12.h),
              AppButton(
                label: '次要按钮',
                onPressed: () => Get.snackbar('提示', '点击了次要按钮'),
                style: AppButtonStyle.secondary,
              ),
              SizedBox(height: 12.h),
              Obx(() => AppButton(
                    label: '加载按钮',
                    onPressed: logic.showLoadingDemo,
                    isLoading: state.isLoading.value,
                  )),
              SizedBox(height: 12.h),
              AppButton(
                label: '禁用按钮',
                onPressed: null,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildComponentCard(
          title: 'AppInput - 输入框组件',
          theme: theme,
          child: Column(
            children: [
              AppInput(
                controller: state.inputController,
                label: '基础输入框',
                hintText: '请输入内容',
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: state.searchController,
                label: '搜索输入框',
                hintText: '搜索...',
                suffixIcon: const Icon(Icons.search),
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: TextEditingController(),
                label: '密码输入框',
                hintText: '请输入密码',
                obscureText: true,
              ),
              SizedBox(height: 12.h),
              AppInput(
                controller: TextEditingController(),
                label: '禁用输入框',
                hintText: '不可编辑',
                enabled: false,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildComponentCard(
          title: 'AppText - 文本组件',
          theme: theme,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                '这是标题文本',
                style: theme.textTheme.titleLarge,
              ),
              SizedBox(height: 8.h),
              AppText(
                '这是正文文本，可以显示较长的内容',
                style: theme.textTheme.bodyMedium,
              ),
              SizedBox(height: 8.h),
              AppText(
                '这是小号文本',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              SizedBox(height: 8.h),
              AppText(
                '这是主题色文本',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildComponentCard(
          title: 'AppLoading - 加载组件',
          theme: theme,
          child: Column(
            children: [
              const AppLoading(),
              SizedBox(height: 16.h),
              const AppLoading(label: '加载中...'),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(width: 16.w),
                  Text('原生加载指示器', style: theme.textTheme.bodyMedium),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCommonComponents(
    ComponentShowcaseLogic logic,
    state,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentCard(
          title: 'AppEmpty - 空状态组件',
          theme: theme,
          child: Column(
            children: [
              const AppEmpty(message: '暂无数据'),
              SizedBox(height: 16.h),
              const AppEmpty(message: '暂无内容'),
              SizedBox(height: 16.h),
              AppEmpty(
                message: '自定义空状态',
                icon: Icons.inbox_outlined,
                onRetry: () => Get.snackbar('提示', '点击了重试'),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInteractionExamples(
    ComponentShowcaseLogic logic,
    state,
    ThemeData theme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildComponentCard(
          title: '对话框和弹窗',
          theme: theme,
          child: Column(
            children: [
              AppButton(
                label: '显示对话框',
                onPressed: logic.showDialogDemo,
              ),
              SizedBox(height: 12.h),
              AppButton(
                label: '显示底部弹窗',
                onPressed: logic.showBottomSheetDemo,
              ),
              SizedBox(height: 12.h),
              AppButton(
                label: '显示 Snackbar',
                onPressed: () => Get.snackbar(
                  '提示',
                  '这是一个 Snackbar 消息',
                  snackPosition: SnackPosition.bottom,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildComponentCard(
          title: '图标示例',
          theme: theme,
          child: Wrap(
            spacing: 16.w,
            runSpacing: 16.h,
            children: [
              _buildIconExample(Icons.home, '首页', theme),
              _buildIconExample(Icons.search, '搜索', theme),
              _buildIconExample(Icons.person, '个人', theme),
              _buildIconExample(Icons.settings, '设置', theme),
              _buildIconExample(Icons.favorite, '收藏', theme),
              _buildIconExample(Icons.notifications, '通知', theme),
              _buildIconExample(Icons.share, '分享', theme),
              _buildIconExample(Icons.delete, '删除', theme),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        _buildComponentCard(
          title: '颜色示例',
          theme: theme,
          child: Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: [
              _buildColorBox('Primary', theme.colorScheme.primary, theme),
              _buildColorBox('Secondary', theme.colorScheme.secondary, theme),
              _buildColorBox('Error', theme.colorScheme.error, theme),
              _buildColorBox('Surface', theme.colorScheme.surface, theme),
              _buildColorBox(
                'Container',
                theme.colorScheme.primaryContainer,
                theme,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildComponentCard({
    required String title,
    required ThemeData theme,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _buildIconExample(IconData icon, String label, ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 32.sp, color: theme.colorScheme.primary),
        SizedBox(height: 4.h),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildColorBox(String label, Color color, ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: theme.colorScheme.outline.withValues(alpha: 0.2),
            ),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: theme.textTheme.bodySmall,
        ),
      ],
    );
  }
}
