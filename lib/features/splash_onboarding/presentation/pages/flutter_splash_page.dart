import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/router/routers_name.dart';

import '../bloc/splash_onboarding_bloc.dart';
import '../bloc/splash_onboarding_event.dart';
import '../bloc/splash_onboarding_state.dart';

class FlutterSplashPage extends StatefulWidget {
  const FlutterSplashPage({super.key});

  @override
  State<FlutterSplashPage> createState() => _FlutterSplashPageState();
}

class _FlutterSplashPageState extends State<FlutterSplashPage> {
  bool _appStartedCalled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _appStartedCalled) return;
      context.read<SplashOnboardingBloc>().add(const AppStartedEvent());
      _appStartedCalled = true; // يضمن أن الحدث يرسل مرة واحدة فقط
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashOnboardingBloc, SplashOnboardingState>(
      listener: (context, state) {
        if (state is ShowLoginPage) {
          Navigator.pushReplacementNamed(context, RoutesName.login);
        } else if (state is NavigateToHome) {
          Navigator.pushReplacementNamed(context, RoutesName.home);
        } else if (state is ShowOnboarding) {
          Navigator.pushReplacementNamed(context, RoutesName.onboardingPage);
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
