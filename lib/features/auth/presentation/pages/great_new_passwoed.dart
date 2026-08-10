import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/inputs/app_text_field.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';

class GreatNewPasswoed extends StatefulWidget {
  const GreatNewPasswoed({super.key});

  @override
  State<GreatNewPasswoed> createState() => _GreatNewPasswoedState();
}

class _GreatNewPasswoedState extends State<GreatNewPasswoed> {
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset successfully')),
          );

          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.login,
            (root) => false,
          );
        } else if (state is ResetPasswordError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(
            title: AppStringsAuth.greatNewPasswoed,
            leading: Icon(Icons.arrow_back_ios_new),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              padding: AppPadding.horizontalPagePaddingAndTop,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 270,
                    child: Text(
                      AppStringsAuth
                          .yourNewPasswordMustBeDifferentFromThePreviousNumber,
                    ),
                  ),
                  Padding(
                    padding: AppPadding.topWidgetPadding,
                    child: AppTextField(
                      controller: _passwordController1,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      label: 'Password',
                      hint: AppStringsAuth.passwordExample,
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                  ),
                  Padding(
                    padding: AppPadding.topWidgetPadding,
                    child: AppTextField(
                      controller: _passwordController2,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController1.text.trim()) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      label: ' Confirm Password',
                      hint: AppStringsAuth.passwordExample,
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outline),
                    ),
                  ),
                  SizedBox(height: 50),
                  Padding(
                    padding: AppPadding.elevatedButtonPadding,
                    child: AppElevatedButton(
                      label: AppStringsAuth.changePassword,
                      isLoading: state is AuthLoading,
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                final bloc = context.read<AuthBloc>();
                                final email = bloc.currentEmail;

                                if (email == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text("Something went wrong"),
                                    ),
                                  );
                                  return;
                                }

                                context.read<AuthBloc>().add(
                                  ResetPasswordEvent(
                                    email: email,
                                    newPassword: _passwordController1.text
                                        .trim(),
                                  ),
                                );
                              }
                            },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
