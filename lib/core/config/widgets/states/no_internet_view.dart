import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/states/app_error_state.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return AppErrorState(
      icon: Icons.wifi_off_rounded,
      iconColor: ColorManager.textPrimary,
      title: 'No internet connection',
      subtitle: 'Please check your network and try again',
      primaryLabel: 'Retry',
      onPrimaryPressed: onRetry,
      secondaryLabel: 'Go to setting',
      onSecondaryPressed: () {
        AppSettings.openAppSettings(type: AppSettingsType.settings);
      },
    );
  }
}
