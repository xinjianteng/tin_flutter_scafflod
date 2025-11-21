import 'package:get/get.dart';

import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  Future<void> mockFetch() async {
    if (state.isBusy.value) return;
    state.isBusy.value = true;
    await Future.delayed(const Duration(milliseconds: 600));
    state.isBusy.value = false;
  }
}
