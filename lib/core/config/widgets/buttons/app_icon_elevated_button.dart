import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class AppIconElevatedButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final EdgeInsets padding;

  const AppIconElevatedButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          backgroundColor: WidgetStateProperty.all(ColorManager.primary),
        ),
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: AppSizes.customTextButtonSized,
          color: ColorManager.backgroundLight,
        ),
        label: Padding(
          padding: padding,
          child: Text(
            label,
            style: TextStyle(
              color: ColorManager.backgroundLight,
              fontSize: AppSizes.customTextButtonSized,
            ),
          ),
        ),
      ),
    );
  }
}
