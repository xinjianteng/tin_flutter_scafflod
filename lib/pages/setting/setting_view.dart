import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routers/routes.dart';
import '../../utils/utils.dart';
import '../../values/values.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  Future<void> _clearLogin() async {
    await PrefsUtil().setOauth('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.setting),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('跟随系统暗色模式'),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (_) {},
          ),
          ListTile(
            title: const Text('清除模拟登录数据'),
            trailing: const Icon(Icons.cleaning_services_outlined),
            onTap: _clearLogin,
          ),
          ListTile(
            title: const Text('组件展示'),
            subtitle: const Text('查看所有通用组件案例'),
            trailing: const Icon(Icons.widgets_outlined),
            onTap: () => Get.toNamed(AppRoutes.componentShowcase),
          ),
          ListTile(
            title: const Text('关于'),
            subtitle: const Text('查看版本与作者'),
            onTap: () => Get.toNamed(AppRoutes.aboutApp),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              '将你的个性化设置项添加在这里，例如主题、通知、缓存清理等。',
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
