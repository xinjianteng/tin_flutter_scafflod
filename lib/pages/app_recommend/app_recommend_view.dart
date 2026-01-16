import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../values/values.dart';

class AppRecommendPage extends StatelessWidget {
  const AppRecommendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('应用推荐')),
      body: ListView(
        padding: EdgeInsets.all(16.w),
        children: [
          _buildAppItem(
            name: 'Tin English',
            desc: '专注雅思英语学习，高效背单词。',
            color: Colors.blueAccent,
          ),
          SizedBox(height: 16.h),
          _buildAppItem(
            name: '每日古文',
            desc: '每天一篇精选古文，陶冶情操。',
            color: Colors.brown,
          ),
           SizedBox(height: 16.h),
          _buildAppItem(
            name: '次元壁纸',
            desc: '海量二次元高清壁纸，让你的手机与众不同。',
            color: Colors.pinkAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildAppItem({
    required String name,
    required String desc,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.apps, color: Colors.white, size: 30.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  desc,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.btnBackground,
              foregroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
            child: const Text('去看看'),
          ),
        ],
      ),
    );
  }
}
