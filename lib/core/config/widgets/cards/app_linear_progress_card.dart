import 'package:flutter/material.dart';
import 'app_custom_card.dart';

class AppLinearProgressCard extends StatelessWidget {
  final String title;
  final double value; // 0..1
  final String? trailing;

  const AppLinearProgressCard({
    super.key,
    required this.title,
    required this.value,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final percent = (value * 100).clamp(0, 100).toStringAsFixed(0);

    return AppCustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title)),
              Text(trailing ?? '$percent%'),
            ],
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(value: value.clamp(0, 1)),
        ],
      ),
    );
  }
}
