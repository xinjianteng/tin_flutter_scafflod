import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/models/oauth.dart';
import 'package:tin_flutter_scafflod/service/oauth_service.dart';

import 'profile_state.dart';

class ProfileLogic extends GetxController {
  final OauthService authService;
  late final ProfileState state;

  ProfileLogic({required this.authService}) {
    state = ProfileState(authService);
  }

  Future<void> logout() async {
    await authService.logout();
  }

  Future<void> mockLogin() async {
    final oauth = ExampleOauth(
      accessToken: 'mock-token',
      userName: 'Tin User',
      userId: '10001',
    );
    await authService.login(oauth);
  }
}
