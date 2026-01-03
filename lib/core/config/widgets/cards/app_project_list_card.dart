import 'package:flutter/material.dart';
import 'app_custom_card.dart';

class AppProjectListCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress; // 0..1
  final VoidCallback? onTap;

  const AppProjectListCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.progress,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: progress.clamp(0, 1)),
        ],
      ),
    );
  }
}
