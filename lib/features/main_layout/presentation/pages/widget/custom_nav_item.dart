import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class CustomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomNavItem({
    super.key,
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(32.r),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(32.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeInOut,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xffF8F9FD)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(32.r),
              ),
              alignment: Alignment.center,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                tween: Tween<double>(begin: 0, end: isSelected ? 1 : 0),
                builder: (context, value, child) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 180),
                        transitionBuilder: (child, animation) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                        child: Icon(
                          isSelected ? activeIcon : icon,
                          key: ValueKey(isSelected),
                          size: 22.sp,
                          color: isSelected
                              ? ColorManager.primary
                              : Colors.white,
                        ),
                      ),

                      ClipRect(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          widthFactor: value,
                          child: Opacity(
                            opacity: value,
                            child: Padding(
                              padding: EdgeInsets.only(left: 9.w),
                              child: Text(
                                label,
                                maxLines: 1,
                                softWrap: false,
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
