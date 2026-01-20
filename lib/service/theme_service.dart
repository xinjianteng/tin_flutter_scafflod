import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/prefs_util.dart';
import '../values/colors.dart';

/// 主题管理服务
class ThemeService extends GetxService {
  static const String _themeKey = 'app_theme_mode';

  final Rx<ThemeMode> _themeMode = ThemeMode.system.obs;
  ThemeMode get themeMode => _themeMode.value;
  bool get isDark => Get.isDarkMode;

  @override
  void onInit() {
    super.onInit();
    _loadTheme();
  }

  void _loadTheme() {
    final saved = PrefsUtil().getString(_themeKey);
    if (saved != null) {
      _themeMode.value = ThemeMode.values.firstWhere(
        (e) => e.name == saved,
        orElse: () => ThemeMode.system,
      );
    }
  }

  void setTheme(ThemeMode mode) {
    _themeMode.value = mode;
    PrefsUtil().setString(_themeKey, mode.name);
    Get.changeThemeMode(mode);
  }

  void toggleTheme() {
    setTheme(isDark ? ThemeMode.light : ThemeMode.dark);
  }

  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: Colors.white,
          error: AppColors.error,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      );

  static ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: const Color(0xFF1E1E1E),
          error: AppColors.error,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      );
}
