import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/states/app_error_state.dart';

class ServerErrorView extends StatelessWidget {
  const ServerErrorView({
    super.key,
    required this.onRetry,
    required this.onContactSupport,
  });

  final VoidCallback onRetry;
  final VoidCallback onContactSupport;

  @override
  Widget build(BuildContext context) {
    return AppErrorState(
      icon: Icons.dns_outlined,
      iconColor: ColorManager.error,
      title: 'Something went wrong',
      subtitle: 'Our servers are having trouble right now',
      primaryLabel: 'Try again',
      onPrimaryPressed: onRetry,
      secondaryLabel: 'Contact support',
      onSecondaryPressed: onContactSupport,
    );
  }
}
