import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final String? logoAsset;
  final bool? centerTitle;
  final bool? isLoding;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.logoAsset,
    this.centerTitle,
    this.isLoding,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: centerTitle ?? true,
      leading: leading,
      title: logoAsset != null
          ? Row(
              children: [
                Image.asset(logoAsset!, height: 26),
                const SizedBox(width: 10),
                Text(title, style: TextStyle(fontSize: AppSizes.s6)),
              ],
            )
          : Text(
              title,
              style: TextStyle(
                fontSize: AppSizes.fz5,
                fontWeight: FontWeight.bold,
              ),
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
