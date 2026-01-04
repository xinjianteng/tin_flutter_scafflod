import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tin_flutter_scafflod/pages/application/application_logic.dart';
import 'package:tin_flutter_scafflod/pages/application/application_state.dart';
import 'package:tin_flutter_scafflod/values/values.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ApplicationLogic logic = Get.put(ApplicationLogic());
    final ApplicationState state = logic.state;

    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: state.currentIndex.value,
          children: state.tabPages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: state.currentIndex.value,
          onTap: logic.switchTab,
          items: state.navItems,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
