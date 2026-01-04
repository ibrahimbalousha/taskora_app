import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class AppElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final EdgeInsetsGeometry padding;

  const AppElevatedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
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
            : Text(
                label,
                style: TextStyle(
                  color: ColorManager.backgroundLight,
                  fontSize: AppSizes.textButtonSized,
                ),
              ),
      ),
    );
  }
}
