import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/widget/custom_nav_item.dart';

class CustomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(left: 30.w, right: 30.w, bottom: 16.h),
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Row(
          children: [
            CustomNavItem(
              label: 'Home',
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              isSelected: currentIndex == 0,
              onTap: () => onTap(0),
            ),
            CustomNavItem(
              label: 'Projects',
              icon: Icons.laptop_mac_outlined,
              activeIcon: Icons.laptop_mac,
              isSelected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
            CustomNavItem(
              label: 'Profile',
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              isSelected: currentIndex == 2,
              onTap: () => onTap(2),
            ),
          ],
        ),
      ),
    );
  }
}
