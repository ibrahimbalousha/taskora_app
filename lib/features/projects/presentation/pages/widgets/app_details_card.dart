import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class AppDetailsCard extends StatelessWidget {
  const AppDetailsCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.r),
        margin: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: ColorManager.textPrimary),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 22.r, color: ColorManager.primary),
                SizedBox(width: 4.w),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorManager.textSecondary,
                  ),
                ),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                color: ColorManager.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
