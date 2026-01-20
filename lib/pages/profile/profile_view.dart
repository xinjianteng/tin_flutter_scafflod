import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import '../../routers/routes.dart';
import '../../service/oauth_service.dart';
import '../../values/values.dart';
import 'profile_logic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, this.showAppBar = true});

  final bool showAppBar;

  @override
  Widget build(BuildContext context) {
    final authService = Get.find<OauthService>();
    final ProfileLogic logic = Get.put(
      ProfileLogic(
        authService: authService,
      ),
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // Light grey background
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                if (showAppBar) ...[
                  SizedBox(height: 10.h),
                  _buildTopBar(context),
                ],
                SizedBox(height: 20.h),
                _buildUserInfo(context, authService, logic),
                SizedBox(height: 24.h),
                _buildVipCard(context),
                SizedBox(height: 16.h),
                _buildCloudStorage(context),
                SizedBox(height: 16.h),
                _buildMenuSection(context),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            Get.changeThemeMode(
              Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
            );
            SmartDialog.showToast(Get.isDarkMode ? '已切换至日间模式' : '已切换至夜间模式');
          },
          icon: Icon(
            Get.isDarkMode ? Icons.wb_sunny_rounded : Icons.nightlight_round,
            color: AppColors.textPrimary,
          ),
        ),
        IconButton(
          onPressed: () {
            Get.toNamed(AppRoutes.setting);
          },
          icon: const Icon(Icons.settings_outlined, color: AppColors.textPrimary),
        ),
      ],
    );
  }

  Widget _buildUserInfo(
    BuildContext context,
    OauthService authService,
    ProfileLogic logic,
  ) {
    return Obx(() {
      final user = authService.user.value;
      final oauth = authService.oauth.value;
      final isLogin = authService.isLogin.value;
      final username = isLogin ? (user.username ?? 'Tin User') : '未登录';
      final userId =  '------';

      return Column(
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: 40.w,
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  // Replace with actual image if available
                  // backgroundImage: const AssetImage('assets/images/avatar_placeholder.png'),
                  child: Text(
                    username.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontSize: 32.sp,
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(6.w),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 14.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            username,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'T号: $userId',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(width: 4.w),
              GestureDetector(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: userId));
                  SmartDialog.showToast('已复制');
                },
                child: Icon(
                  Icons.copy,
                  size: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          if (isLogin)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4E6), // Light Pink
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.diamond_outlined, color: AppColors.secondary, size: 14.sp),
                  SizedBox(width: 4.w),
                  Text(
                    '尊享 VIP 会员',
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            )
          else
            ElevatedButton(
              onPressed: logic.mockLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: Size(100.w, 36.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: const Text('立即登录'),
            ),
        ],
      );
    });
  }

  Widget _buildVipCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFD48E7E), Color(0xFFA45D51)], // Brownish Red
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFA45D51).withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.verified_user, color: Colors.white, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    '超级会员生效中',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6.h),
              Text(
                '有效期至 2025-12-31',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFFA45D51),
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
              minimumSize: Size(0, 32.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: Text(
              '续费',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloudStorage(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.cloud_outlined, color: AppColors.primary, size: 20.sp),
                  SizedBox(width: 8.w),
                  Text(
                    '云端容量',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Row(
                  children: [
                    Icon(Icons.all_inclusive, size: 12.sp, color: AppColors.primary),
                    SizedBox(width: 4.w),
                    Text(
                      '无限容量',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(4.h),
            child: LinearProgressIndicator(
              value: 0.1, // Mock value
              backgroundColor: AppColors.background,
              color: AppColors.primary,
              minHeight: 6.h,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '已用 12.5 GB',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              Text(
                'VIP 专享无限空间',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.save_alt_outlined,
            title: '本地存储管理',
            onTap: () => Get.toNamed(AppRoutes.storageManager),
          ),
          const Divider(height: 1, indent: 56),
          _buildMenuItem(
            icon: Icons.ios_share_outlined,
            title: '笔记导出',
            onTap: () {
              SmartDialog.show(
                builder: (context) {
                  return Container(
                    width: 300.w,
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.diamond, size: 48, color: AppColors.secondary),
                        SizedBox(height: 16.h),
                        Text(
                          'VIP 专属功能',
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8.h),
                        const Text('导出高清 PDF 笔记与精美排版，尽享尊贵体验。'),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () => SmartDialog.dismiss(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondary,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('立即开通'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            trailingWidget: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: const Color(0xFFFFE4E6),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Text(
                'VIP',
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
            ),
          ),
          const Divider(height: 1, indent: 56),
          _buildMenuItem(
            icon: Icons.chat_bubble_outline,
            title: '问题反馈',
            onTap: () => Get.toNamed(AppRoutes.feedback),
          ),
          const Divider(height: 1, indent: 56),
          _buildMenuItem(
            icon: Icons.thumb_up_alt_outlined,
            title: '应用推荐',
            onTap: () => Get.toNamed(AppRoutes.appRecommend),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailingWidget,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(icon, color: AppColors.textPrimary, size: 20.sp),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textPrimary,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingWidget != null) trailingWidget,
          Icon(Icons.chevron_right, color: AppColors.textSecondary, size: 20.sp),
        ],
      ),
    );
  }
}

