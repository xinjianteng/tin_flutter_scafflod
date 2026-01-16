/// 使用方法：Get.find<OauthService>().login(oauth);
import 'dart:convert';

import 'package:get/get.dart';

import '../models/models.dart';
import '../utils/utils.dart';

class OauthService extends GetxService {
  final oauth = ExampleOauth().obs;
  final user = ExampleUser().obs;
  final isLogin = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadPersistedSession();
  }

  Future<void> _loadPersistedSession() async {
    try {
      final oauthJson = await StorageUtil.getSecureString(
        StorageUtil.keyOauth,
      );
      if (oauthJson == null || oauthJson.isEmpty) return;

      oauth.value = ExampleOauth.fromJson(jsonDecode(oauthJson));
      _updateLoginStatus(oauth.value);
      user.value = ExampleUser(username: oauth.value.userName);
    } catch (e) {
      Get.log('Error decoding OAuth data: $e', isError: true);
    }
  }

  void _updateLoginStatus(ExampleOauth? oauthNew) {
    if (oauthNew == null) {
      isLogin.value = false;
      oauth.value = ExampleOauth();
      user.value = ExampleUser();
      return;
    }

    if (oauthNew.accessToken != null) {
      oauth.value = oauthNew;
      isLogin.value = true;
    } else {
      isLogin.value = false;
    }
  }

  Future<void> login(ExampleOauth oauthNew) async {
    try {
      _updateLoginStatus(oauthNew);
      user.value = ExampleUser(
        username: oauthNew.userName ?? '示例用户',
      );
      await StorageUtil.setSecureString(
        StorageUtil.keyOauth,
        jsonEncode(oauthNew),
      );
    } catch (e) {
      Get.log('Error saving OAuth data: $e', isError: true);
    }
  }

  Future<void> logout() async {
    try {
      _updateLoginStatus(null);
      await StorageUtil.remove(StorageUtil.keyOauth);
    } catch (e) {
      Get.log('Error clearing OAuth data: $e', isError: true);
    }
  }
}
