import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/app_strings.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/inputs/app_text_field.dart';
import 'package:taskora_app/core/config/widgets/text/app_rich_text.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_state.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final watchCostController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    watchCostController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.login,
            (route) => false,
          );
        }

        if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStringsAuth.createAAccount,
          leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Padding(
          padding: AppPadding.horizontalPagePaddingAndTop,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStringsAuth.createYourAccountAndEnjoyTheBestServices),
              AppTextField(
                label: 'Name',
                hint: AppStringsAuth.enterYourName,
                controller: nameController,
              ),
              AppTextField(
                label: 'UserName',
                hint: AppStringsAuth.enterYourUserName,
                controller: usernameController,
              ),

              AppTextField(
                label: 'E-mail',
                hint: AppStringsAuth.hintEmailExample,
                prefixIcon: const Icon(Icons.email_outlined),
                controller: emailController,
              ),
              AppTextField(
                label: 'Password',
                hint: AppStringsAuth.passwordExample,
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility_off),
                controller: passwordController,
              ),
              AppTextField(
                label: 'Hourly Rate ',
                hint: '\$50',
                suffixIcon: Icon(Icons.monetization_on_outlined),
                controller: watchCostController,
              ),
              Padding(
                padding: AppPadding.elevatedButtonPadding,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    return AppElevatedButton(
                      label: AppStringsAuth.signUp,
                      onPressed: () async {
                        context.read<AuthBloc>().add(
                          SignUpEvent(
                            name: nameController.text.trim(),
                            username: usernameController.text.trim(),
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            watchCost: watchCostController.text.trim(),
                          ),
                        );
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString(
                          'username',
                          usernameController.text.trim(),
                        );
                      },
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: AppRichText(
                  text: AppStringsAuth.doYouHaveAnAccount,
                  actionText: AppStringsAuth.logIn,
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.login,
                      (route) => false,
                    );
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
