import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/extensions/text_style_extension.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.icon,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.onChanged,
    this.onSubmitted,
    this.errorText,
    this.borderRadius = AppRadius.md,
  });

  final TextEditingController? controller;

  final String? label;
  final String? hint;
  final IconData? icon;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final bool obscureText;
  final bool enabled;
  final bool readOnly;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final String? errorText;

  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final hasError = errorText != null && errorText!.trim().isNotEmpty;

    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: color, width: 1.0),
    );

    final enabledBorderColor = theme.colorScheme.outline;
    final focusedBorderColor = theme.colorScheme.primary;
    final errorBorderColor = theme.colorScheme.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (label != null && label!.trim().isNotEmpty) ...[
          Text(
            label!,
            textAlign: TextAlign.right,
            style: theme.textTheme.fieldLabel,
          ),
          const SizedBox(height: AppSpacing.x2),
        ],
        Directionality(
          textDirection: TextDirection.rtl,
          child: TextField(
            controller: controller,
            enabled: enabled,
            readOnly: readOnly,
            obscureText: obscureText,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            textAlign: TextAlign.right,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: hint,
              isDense: true,
              filled: true,
              fillColor: theme.colorScheme.surface,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.x4,
                vertical: AppSpacing.x4,
              ),

              // In RTL, prefixIcon appears on the RIGHT (matches your design)
              prefixIcon: icon == null ? null : Icon(icon, size: AppSpacing.x5),
              prefixIconConstraints: const BoxConstraints(
                minWidth: AppSpacing.x11,
                minHeight: AppSpacing.x11,
              ),

              enabledBorder: border(
                hasError ? errorBorderColor : enabledBorderColor,
              ),
              focusedBorder: border(
                hasError ? errorBorderColor : focusedBorderColor,
              ),
              errorBorder: border(errorBorderColor),
              focusedErrorBorder: border(errorBorderColor),

              // We handle error below (optional)
              errorText: null,
            ),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: AppSpacing.x2),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.error_outline,
                  size: AppSpacing.x4,
                  color: errorBorderColor,
                ),
                const SizedBox(width: AppSpacing.x2),
                Flexible(
                  child: Text(
                    errorText!,
                    textAlign: TextAlign.right,
                    style: theme.textTheme.fieldError(errorBorderColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
