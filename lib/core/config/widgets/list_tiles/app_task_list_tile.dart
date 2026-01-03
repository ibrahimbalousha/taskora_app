import 'package:flutter/material.dart';
import '../badges/app_status_badge.dart';
import '../cards/app_custom_card.dart';

class AppTaskListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String statusLabel;
  final Color statusColor;
  final VoidCallback? onTap;

  const AppTaskListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.statusLabel,
    required this.statusColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCustomCard(
      onTap: onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 4),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          const SizedBox(width: 12),
          AppStatusBadge(label: statusLabel, color: statusColor),
        ],
      ),
    );
  }
}
