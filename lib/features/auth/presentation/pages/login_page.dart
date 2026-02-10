import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/inputs/app_text_field.dart';
import 'package:taskora_app/core/config/widgets/text/app_rich_text.dart';
import 'package:taskora_app/core/config/widgets/text/blue_main_text.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (_) => AuthBloc(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          // show loader if needed
        } else if (state is AuthSuccess) {
          // TODO: navigate to home (via router)
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStringsAuth.logIn,
          leading: const Icon(Icons.arrow_back_ios_new),
        ),
        body: Padding(
          padding: AppPadding.horizontalPagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: AppPadding.topPagePadding,
                child: BlueMainText(text: AppStringsAuth.welcomeBack),
              ),
              Text(AppStringsAuth.pleaseLoginOrSignUpToContinueOurOpp),

              /// Email
              Padding(
                padding: AppPadding.topTextFieldPadding,
                child: AppTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  hint: 'example@gmail.com',
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),

              /// Password
              Padding(
                padding: AppPadding.topTextFieldPadding,
                child: AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: AppStringsAuth.passwordExample,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: const Icon(Icons.visibility_off),
                ),
              ),

              /// Remember me
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    fillColor: WidgetStateProperty.all(Colors.white),
                    side: const BorderSide(
                      color: ColorManager.primary,
                      width: 1.5,
                    ),
                    checkColor: ColorManager.primary,
                    visualDensity: VisualDensity.compact,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text(
                    AppStringsCommon.rememberMe,
                    style: TextStyle(
                      color: ColorManager.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              /// Login button
              Padding(
                padding: AppPadding.elevatedButtonPadding,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AppElevatedButton(
                      label: AppStringsAuth.logIn,
                      isLoading: state is AuthLoading,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              ),
                            );
                      },
                    );
                  },
                ),
              ),

              /// Navigate to signup
              Align(
                alignment: Alignment.center,
                child: AppRichText(
                  text: AppStringsAuth.dontHaveAnAccount,
                  actionText: AppStringsAuth.createAAccount,
                  onTap: () {
                    // TODO: navigate to signup
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
