import 'package:flutter/material.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/inputs/app_text_field.dart';
import 'package:taskora_app/core/config/widgets/text/app_rich_text.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStringsAuth.createAAccount,
        leading: Icon(Icons.arrow_back_ios_new),
      ),
      body: Padding(
        padding: AppPadding.horizontalPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: AppPadding.topPagePadding,
              child: Text(
                AppStringsAuth.createYourAccountAndEnjoyTheBestServices,
              ),
            ),
            AppTextField(label: 'Name', hint: AppStringsAuth.enterYourName),
            AppTextField(
              label: 'E-mail',
              hint: AppStringsAuth.hintEmailExample,
              prefixIcon: const Icon(Icons.email_outlined),
            ),
            AppTextField(
              label: 'Password',
              hint: AppStringsAuth.passwordExample,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: Icon(Icons.visibility_off),
            ),
            AppTextField(
              label: 'Hourly Rate ',
              hint: '\$50',
              suffixIcon: Icon(Icons.monetization_on_outlined),
            ),
            Padding(
              padding: AppPadding.elevatedButtonPadding,
              child: AppElevatedButton(
                label: AppStringsAuth.signUp,
                onPressed: () {},
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: AppRichText(
                text: AppStringsAuth.doYouHaveAnAccount,
                actionText: AppStringsAuth.logIn,
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
