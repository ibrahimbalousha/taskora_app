import 'package:flutter/material.dart';
import '../../constants/color_manager.dart';
import '../badges/app_status_badge.dart';
import '../cards/app_custom_card.dart';

class AppTaskListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String statusLabel;
  final Color statusColor;
  final Color? accentColor;
  final VoidCallback? onTap;

  const AppTaskListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.statusLabel,
    required this.statusColor,
    this.accentColor,
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
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(subtitle!, style: Theme.of(context).textTheme.bodySmall),
                ],
              ],
            ),
          ),
          const SizedBox(width: 12),
          AppStatusBadge(label: statusLabel, color: statusColor),
          if (accentColor != null) ...[
            const SizedBox(width: 10),
            Container(
              width: 4,
              height: 28,
              decoration: BoxDecoration(
                color: accentColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
