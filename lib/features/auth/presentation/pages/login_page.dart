import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/buttons/custom_text_button.dart';
import 'package:taskora_app/core/config/widgets/feedback/app_snack_bar.dart';
import 'package:taskora_app/core/config/widgets/inputs/app_text_field.dart';
import 'package:taskora_app/core/config/widgets/text/app_rich_text.dart';
import 'package:taskora_app/core/config/widgets/text/blue_main_text.dart';
import 'package:taskora_app/core/di/service_locator.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool obscureText = true;

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
          final projectCubit = locator<ProjectCubit>();
          projectCubit.getProject();

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.home,
            (_) => false,
          );
        } else if (state is LoginError) {
          AppSnackBar.show(context, message: state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: AppStringsAuth.logIn),
        body: SingleChildScrollView(
          padding: AppPadding.horizontalPagePaddingAndTop,
          child: Form(
            key: _formKey,

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
                    hint: AppStringsAuth.hintEmailExample,
                    keyboardType: TextInputType.emailAddress,
                    prefixIcon: const Icon(Icons.email_outlined),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address correctly.';
                      }

                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address.';
                      }

                      return null;
                    },
                  ),
                ),

                Padding(
                  padding: AppPadding.topWidgetPadding,
                  child: AppTextField(
                    controller: _passwordController,
                    label: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        obscureText = !obscureText;
                        setState(() {});
                      },
                      icon: Icon(
                        obscureText
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    hint: AppStringsAuth.passwordExample,
                    obscureText: obscureText,
                    prefixIcon: const Icon(Icons.lock_outline),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                ),

                CustomTextButton(
                  label: AppStringsAuth.forgetPassword,
                  onPressed: () {
                    Navigator.pushNamed(context, RoutesName.recoverByEmail);
                  },
                ),

                Padding(
                  padding: AppPadding.elevatedButtonPadding,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return AppElevatedButton(
                        label: AppStringsAuth.logIn,
                        isLoading: state is AuthLoading,
                        onPressed: state is AuthLoading
                            ? null
                            : () async {
                                if (_formKey.currentState!.validate()) {
                                  context.read<AuthBloc>().add(
                                    LoginEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                                }
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
      ),
    );
  }
}
