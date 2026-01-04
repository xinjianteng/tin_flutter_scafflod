import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/models/oauth.dart';
import 'package:tin_flutter_scafflod/routers/routes.dart';
import 'package:tin_flutter_scafflod/service/oauth_service.dart';

import 'login_state.dart';

class LoginLogic extends GetxController {
  final LoginState state = LoginState();
  final OauthService authService;

  LoginLogic({required this.authService});

  Future<void> mockLogin() async {
    final oauth = ExampleOauth(
      accessToken: 'mock-token',
      userId: '10001',
      userName: '示例用户',
    );
    await authService.login(oauth);
    Get.offAllNamed(AppRoutes.application);
  }
}
