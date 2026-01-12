import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/pages/onboarding_page.dart';

import '../bloc/splash_onboarding_bloc.dart';
import '../bloc/splash_onboarding_event.dart';
import '../bloc/splash_onboarding_state.dart';
import 'home_page.dart';

class FlutterSplashPage extends StatefulWidget {
  const FlutterSplashPage({super.key});

  @override
  State<FlutterSplashPage> createState() => _FlutterSplashPageState();
}

class _FlutterSplashPageState extends State<FlutterSplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<SplashOnboardingBloc>().add(const AppStartedEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashOnboardingBloc, SplashOnboardingState>(
      listener: (context, state) {
        if (state is ShowOnboarding) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const OnboardingPage()),
          );
        } else if (state is NavigateToHome) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        }
      },
      child: const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
