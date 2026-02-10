import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';

class AppEmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageAsset;
  final String? buttonLabel;
  final VoidCallback? onPressed;

  const AppEmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    this.buttonLabel,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imageAsset, height: 220),
            const SizedBox(height: 16),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(subtitle, textAlign: TextAlign.center),
            if (buttonLabel != null && onPressed != null) ...[
              const SizedBox(height: 16),
              AppElevatedButton(label: buttonLabel!, onPressed: onPressed),
            ],
          ],
        ),
      ),
    );
  }
}
