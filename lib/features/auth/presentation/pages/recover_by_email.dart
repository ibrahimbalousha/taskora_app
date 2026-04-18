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

class RecoverByEmail extends StatefulWidget {
  const RecoverByEmail({super.key});

  @override
  State<RecoverByEmail> createState() => _RecoverByEmailState();
}

class _RecoverByEmailState extends State<RecoverByEmail> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is ForgotPasswordSuccess) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Reset code sent to your email")),
          );

          Navigator.pushNamed(context, RoutesName.verificationCode);
        }

        if (state is AuthError) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Enter your email address',
          leading: Icon(Icons.arrow_back_ios_new),
        ),
        body: Padding(
          padding: AppPadding.horizontalPagePaddingAndTop,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStringsAuth.youWillReceiveACodeToResetYourPassword,
                  style: TextStyle(),
                ),
                Padding(
                  padding: AppPadding.topWidgetPadding,
                  child: AppTextField(
                    hint: AppStringsAuth.hintEmailExample,
                    label: 'E-mail',
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address correctly so that you can reset your password.';
                      }

                      final emailRegex = RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );

                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter your email address correctly so that you can reset your password.';
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(height: 70),
                AppElevatedButton(
                  label: AppStringsAuth.continueText,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context.read<AuthBloc>().add(
                        ForgotPasswordEvent(
                          email: _emailController.text.trim(),
                          name: '',
                          username: '',
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
