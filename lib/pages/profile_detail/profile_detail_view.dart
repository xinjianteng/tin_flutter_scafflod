/// 使用方法：Get.toNamed(AppRoutes.profileDetail);
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/service/oauth_service.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

import 'profile_detail_logic.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final logic = Get.put(ProfileDetailLogic());
    final state = logic.state;
    final authService = Get.find<OauthService>();
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.profileDetail),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () {
            final userName =
                authService.user.value.username ?? AppStrings.profileUnknownUser;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundColor:
                        theme.colorScheme.primary.withOpacity(0.15),
                    child: const Icon(Icons.person_outline),
                  ),
                  title: Text(userName),
                  subtitle: Text(state.phone.value),
                ),
                const Divider(),
                ListTile(
                  title: const Text('邮箱'),
                  subtitle: Text(state.email.value),
                ),
                ListTile(
                  title: const Text('地址'),
                  subtitle: Text(state.address.value),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
