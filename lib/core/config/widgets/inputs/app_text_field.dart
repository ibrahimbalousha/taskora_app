import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final String? label;
  final FormFieldValidator<String>? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final int maxLines;

  const AppTextField({
    super.key,
    this.controller,
    this.hint,
    this.label,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
  });

  static const Color _iconColor = ColorManager.primary; // primary ثابت

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.s2),
          child: Text(
            "$label",
            style: const TextStyle(
              color: ColorManager.textPrimary,
              fontSize: AppSizes.fz3,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: maxLines,
          cursorColor: ColorManager.primary,
          decoration: InputDecoration(
            hintText: hint,

            floatingLabelBehavior: FloatingLabelBehavior.always,

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),

            prefixIcon: prefixIcon == null
                ? null
                : IconTheme(
                    data: const IconThemeData(color: _iconColor),
                    child: prefixIcon!,
                  ),

            suffixIcon: suffixIcon == null
                ? null
                : IconTheme(
                    data: const IconThemeData(color: _iconColor),
                    child: suffixIcon!,
                  ),

            hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: ColorManager.primary,
                width: 0.5,
              ),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: ColorManager.primary,
                width: 1.5,
              ),
            ),

            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),

            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
