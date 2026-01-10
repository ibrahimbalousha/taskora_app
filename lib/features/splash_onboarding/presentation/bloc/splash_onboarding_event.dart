import 'package:equatable/equatable.dart';

abstract class SplashOnboardingEvent extends Equatable {
  const SplashOnboardingEvent();

  @override
  List<Object?> get props => [];
}

class AppStartedEvent extends SplashOnboardingEvent {
  const AppStartedEvent();
}

class OnboardingCompletedEvent extends SplashOnboardingEvent {
  const OnboardingCompletedEvent();
}
