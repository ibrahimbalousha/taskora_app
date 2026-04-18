import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/inputs/app_text_field.dart';
import 'package:taskora_app/core/config/widgets/text/app_rich_text.dart';
import 'package:taskora_app/core/config/widgets/text/blue_main_text.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushReplacementNamed(context, RoutesName.home);
        } else if (state is AuthError) {
          Navigator.pushNamed(context, RoutesName.loginFailed);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: AppStringsAuth.logIn),
        body: Padding(
          padding: AppPadding.horizontalPagePaddingAndTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BlueMainText(text: AppStringsAuth.welcomeBack),
              Text(AppStringsAuth.pleaseLoginOrSignUpToContinueOurOpp),

              Padding(
                padding: AppPadding.topWidgetPadding,
                child: AppTextField(
                  controller: _emailController,
                  label: 'E-mail',
                  hint:  AppStringsAuth.hintEmailExample,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
              ),

              Padding(
                padding: AppPadding.topWidgetPadding,
                child: AppTextField(
                  controller: _passwordController,
                  label: 'Password',
                  hint: AppStringsAuth.passwordExample,
                  obscureText: true,
                  prefixIcon: const Icon(Icons.lock_outline),
                ),
              ),

              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  const Text(AppStringsCommon.rememberMe),
                ],
              ),

              Padding(
                padding: AppPadding.elevatedButtonPadding,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return AppElevatedButton(
                      label: AppStringsAuth.logIn,
                      isLoading: state is AuthLoading,
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();

                        context.read<AuthBloc>().add(
                          LoginEvent(
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                            username: prefs.getString('username')!,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              Align(
                alignment: Alignment.center,
                child: AppRichText(
                  text: AppStringsAuth.dontHaveAnAccount,
                  actionText: AppStringsAuth.createAAccount,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.signup);
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
