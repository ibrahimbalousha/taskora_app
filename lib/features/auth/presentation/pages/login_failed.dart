import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';

class LoginFailed extends StatelessWidget {
  const LoginFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1F2A44)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: AppPadding.horizontalPagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon circle
            Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.15),
                    blurRadius: 25,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: const Center(
                child: Icon(
                  Icons.lock_outline,
                  size: 60,
                  color: Color(0xFF5B6CFF),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Title
            const Text(
              'login failed',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF5B6CFF),
              ),
            ),

            const SizedBox(height: 12),

            // Description
            const Text(
              'Email is incorrect. Please double-check your credentials.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6B7280),
                height: 1.6,
              ),
            ),

            const SizedBox(height: 40),

            // Try again button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: AppElevatedButton(
                padding: EdgeInsetsGeometry.all(12),
                label: AppStringsCommon.tryAgain,
                onPressed: () {},
              ),
            ),

            const SizedBox(height: 16),

            // Forget password button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: AppElevatedButton(
                inverted: true,
                label: AppStringsAuth.forgetPassword,
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
