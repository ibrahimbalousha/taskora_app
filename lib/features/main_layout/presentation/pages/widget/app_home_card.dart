import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class AppHomeCard extends StatelessWidget {
  const AppHomeCard({super.key, required this.icon, required this.title, required this.value});
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: ColorManager.textPrimary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 22.r),
              SizedBox(width: 4.w),
              Text(title, style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              color: ColorManager.primary,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
