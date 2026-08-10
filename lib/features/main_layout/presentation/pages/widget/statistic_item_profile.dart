import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class StatisticItemProfile extends StatelessWidget {
  const StatisticItemProfile({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
  });
  final IconData icon;
  final String value;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      decoration: BoxDecoration(
        border: Border.all(color: ColorManager.textSecondary),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: ColorManager.primary, size: 26),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(title),
        ],
      ),
    );
  }
}
