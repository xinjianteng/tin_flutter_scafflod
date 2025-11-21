import 'package:get/get.dart';

import 'application_state.dart';

class ApplicationLogic extends GetxController {
  final ApplicationState state = ApplicationState();

  void switchTab(int index) {
    state.currentIndex.value = index;
  }
}
