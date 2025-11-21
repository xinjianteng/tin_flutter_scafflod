import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/pages/pages.dart';
import '/values/values.dart';

class ApplicationState {
  final RxInt currentIndex = 0.obs;

  final List<Widget> tabPages = const [
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  final List<BottomNavigationBarItem> navItems = const [
    BottomNavigationBarItem(
        icon: Icon(Icons.home_outlined), label: AppStrings.home),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: AppStrings.search),
    BottomNavigationBarItem(
        icon: Icon(Icons.person_outline), label: AppStrings.profile),
  ];
}
