import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class AppCustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final Color? color;
  final Color? borderColor;
  final double? radius;

  const AppCustomCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.color,
    this.borderColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    final r = radius ?? AppSizes.r12;
    final p = padding ?? const EdgeInsets.all(AppSizes.s12);

    return Material(
      color: Colors.transparent,
      child: Ink(
        padding: p,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(r),
          border: Border.all(
            color: borderColor ?? ColorManager.borderLight,
            width: 1,
          ),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(r),
          child: child,
        ),
      ),
    );
  }
}
