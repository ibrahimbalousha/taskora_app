import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';

class VerificationCodePage extends StatefulWidget {
  const VerificationCodePage({super.key});

  @override
  State<VerificationCodePage> createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  TextEditingController code = TextEditingController();

  @override
  void dispose() {
    code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is VerifyResetCodeSuccess) {
          Navigator.pushNamed(context, RoutesName.greatNewPasswoed);
        } else if (state is VerifyCodeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          context.read<AuthBloc>().add(ResetAuthState());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: AppStringsCommon.enterCode,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFF1F2A44),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
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
                      controller: code,
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
                    onTap: state is AuthLoading
                        ? null
                        : () {
                            final email = context.read<AuthBloc>().currentEmail;
                            if (email != null) {
                              context.read<AuthBloc>().add(
                                ResendCodeEvent(email: email),
                              );
                            }
                          },
                    child: Text(
                      AppStringsCommon.resendCode,
                      style: TextStyle(
                        color: state is AuthLoading
                            ? Colors.grey
                            : ColorManager.primary,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: AppPadding.elevatedButtonPadding,
                  child: AppElevatedButton(
                    label: AppStringsAuth.verifyEmail,
                    isLoading: state is AuthLoading,
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            if (code.text.trim().length != 4) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please enter a 4-digit code'),
                                ),
                              );
                              return;
                            }

                            final parsedCode = int.tryParse(code.text.trim());

                            if (parsedCode == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Code must be numbers only'),
                                ),
                              );
                              return;
                            }
                            context.read<AuthBloc>().add(
                              VerifyResetCodeEvent(code: parsedCode),
                            );
                          },
                  ),
                ),
                Spacer(flex: 3),
              ],
            ),
          ),
        );
      },
    );
  }
}
