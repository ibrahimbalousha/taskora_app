import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class BlueMainText extends StatelessWidget {
  const BlueMainText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: ColorManager.primary,
        fontWeight: FontWeight.bold,
        fontSize: AppSizes.fz3,
      ),
    );
  }
}
