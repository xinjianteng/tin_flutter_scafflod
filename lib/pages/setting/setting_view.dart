import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/routers/routes.dart';
import 'package:tin_flutter_scafflod/utils/prefs_util.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

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
            title: const Text(AppStrings.settingFollowSystem),
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: (_) {},
          ),
          ListTile(
            title: const Text(AppStrings.settingClearMock),
            trailing: const Icon(Icons.cleaning_services_outlined),
            onTap: _clearLogin,
          ),
          ListTile(
            title: const Text(AppStrings.settingAbout),
            subtitle: const Text(AppStrings.settingAboutSubTitle),
            onTap: () => Get.toNamed(AppRoutes.aboutApp),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              AppStrings.settingPersonalizeTip,
              style: theme.textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}
