import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const CustomTextButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.customTextButtonSized,
        ),
      ),
    );
  }
}
