import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';

class AppErrorState extends StatelessWidget {
  const AppErrorState({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    required this.secondaryLabel,
    required this.onSecondaryPressed,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final String secondaryLabel;
  final VoidCallback? onSecondaryPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 104,
              height: 104,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorManager.backgroundLight,
                border: Border.all(color: ColorManager.borderLight),
              ),
              child: Icon(icon, size: 40, color: iconColor),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: ColorManager.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: ColorManager.textSecondary),
            ),
            const SizedBox(height: 32),
            AppElevatedButton(label: primaryLabel, onPressed: onPrimaryPressed),
            const SizedBox(height: 8),
            AppElevatedButton(
              label: secondaryLabel,
              inverted: true,
              onPressed: onSecondaryPressed,
            ),
          ],
        ),
      ),
    );
  }
}
