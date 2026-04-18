import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({super.key});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStringsCommon.enterCode,
        leading: Icon(Icons.arrow_back_ios_new),
      ),
      body: Padding(
        padding: AppPadding.horizontalPagePaddingAndTop,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 270,
              child: Text(
                AppStringsCommon
                    .pleaseCheakYourEmailForTheConfirmationCodeWeSent,
              ),
            ),
            Center(
              child: Padding(
                padding: AppPadding.pinputPadding,
                child: Pinput(
                  length: 4,
                  defaultPinTheme: PinTheme(
                    width: 50,
                    height: 60,
                    margin: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorManager.textPrimary),
                    ),
                  ),
                  focusedPinTheme: PinTheme(
                    width: 48,
                    height: 58,
                    margin: EdgeInsets.all(6),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: ColorManager.primary),
                    ),
                  ),
                ),
              ),
            ),
            Center(child: Text(AppStringsAuth.correctCode)),
            Spacer(flex: 1),
            Center(child: Text(AppStringsCommon.dontReceiveCode)),
            Center(
              child: InkWell(
                onTap: () {},
                child: Text(
                  AppStringsCommon.resendCode,
                  style: TextStyle(color: ColorManager.primary),
                ),
              ),
            ),
            Padding(
              padding: AppPadding.elevatedButtonPadding,
              child: AppElevatedButton(
                label: AppStringsAuth.verifyEmail,
                onPressed: () {},
              ),
            ),
            Spacer(flex: 3),
          ],
        ),
      ),
    );
  }
}
