import 'dart:ui';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 常用尺寸与间距定义，方便统一适配。
class AppDimens {
  // 设计稿尺寸
  static const double mobileWidth = 375.0;
  static const double mobileHeight = 812.0;
  static const double desktopWidth = 1080.0;
  static const double desktopHeight = 680.0;

  static Size deviceSize = GetPlatform.isMobile
      ? Size(mobileWidth, mobileHeight)
      : Size(desktopWidth, desktopHeight);

  // 间距与线高
  static double space = 5.0.w;
  static double lineH = 0.2.h;
  static double margin = GetPlatform.isMobile ? 16.w : 16;

  // 常用圆角与阴影
  static double radiusSmall = 6.r;
  static double radiusMedium = 12.r;
  static double radiusLarge = 16.r;
  static double elevation = 2.0;

  // 标题/菜单高度
  static const double titleHeight = 54.0;
  static const double menuHeight = 56.0;

  // 按钮规格
  static double btnWidthMin = 48.w;
  static double btnHeightMin = 12.h;
  static double btnWidthNor = GetPlatform.isMobile ? 72.w : 72;
  static double btnHeightNor = GetPlatform.isMobile ? 20.h : 20;
  static double btnWidthMax = GetPlatform.isMobile ? 343.w : 72;
  static double btnHeightMax = GetPlatform.isMobile ? 40.h : 40;
  static double btnFontMin = GetPlatform.isMobile ? 12.sp : 12;
  static double btnFontNor = 14.sp;
  static double btnFontMax = GetPlatform.isMobile ? 16.sp : 16;
  static double btnRadiusMin = GetPlatform.isMobile ? 4.r : 4;
  static double btnRadiusNor = 16.r;
  static double btnRadiusMax = 22.r;
}
