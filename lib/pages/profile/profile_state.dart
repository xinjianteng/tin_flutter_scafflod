import 'package:get/get.dart';

import '../../service/oauth_service.dart';

class ProfileState {
  ProfileState(this.authService);

  final OauthService authService;
  final RxList<String> badges = <String>[].obs;
}
