import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry padding;
  final bool inverted;
  final double? width;
  final Widget? icon;

  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.padding = const EdgeInsets.all(0),
    this.inverted = false,
    this.width,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: inverted ? Colors.white : ColorManager.primary,
          foregroundColor: inverted ? ColorManager.primary : Colors.white,
          side: inverted ? BorderSide(color: ColorManager.primary) : null,
          padding: padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.r8),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null ? icon! : Text(''),
                  SizedBox(width: 8.w),
                  Text(
                    label,
                    style: TextStyle(
                      color: inverted ? ColorManager.primary : Colors.white,
                      fontSize: AppSizes.textButtonSized,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
