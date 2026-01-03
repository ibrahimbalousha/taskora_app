import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final String? logoAsset;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.logoAsset,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      title: Row(
        children: [
          if (logoAsset != null) ...[
            Image.asset(logoAsset!, height: 26),
            const SizedBox(width: 10),
          ],
          Text(title),
        ],
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
