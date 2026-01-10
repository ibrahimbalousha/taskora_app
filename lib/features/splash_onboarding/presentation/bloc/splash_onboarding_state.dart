import 'package:equatable/equatable.dart';

abstract class SplashOnboardingState extends Equatable {
  const SplashOnboardingState();

  @override
  List<Object?> get props => [];
}

class SplashOnboardingInitial extends SplashOnboardingState {
  const SplashOnboardingInitial();
}

class SplashOnboardingLoading extends SplashOnboardingState {
  const SplashOnboardingLoading();
}

class ShowOnboarding extends SplashOnboardingState {
  const ShowOnboarding();
}

class NavigateToHome extends SplashOnboardingState {
  const NavigateToHome();
}
