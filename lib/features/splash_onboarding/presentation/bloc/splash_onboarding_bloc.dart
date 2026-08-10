import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/features/splash_onboarding/domain/usecases/check_login_status_usecase.dart';

import '../../domain/usecases/check_onboarding_status_usecase.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import 'splash_onboarding_event.dart';
import 'splash_onboarding_state.dart';

class SplashOnboardingBloc
    extends Bloc<SplashOnboardingEvent, SplashOnboardingState> {
  final CheckOnboardingStatusUseCase _checkStatus;
  final CompleteOnboardingUseCase _completeOnboarding;
  final CheckLoginStatusUseCase _checkLoginStatus;

  SplashOnboardingBloc({
    required CheckOnboardingStatusUseCase checkStatus,
    required CompleteOnboardingUseCase completeOnboarding,
    required CheckLoginStatusUseCase checkLoginStatus,
  }) : _checkStatus = checkStatus,
       _completeOnboarding = completeOnboarding,
       _checkLoginStatus = checkLoginStatus,
       super(const SplashOnboardingInitial()) {
    on<AppStartedEvent>(_onAppStarted);
    on<OnboardingCompletedEvent>(_onOnboardingCompleted);
  }

  Future<void> _onAppStarted(
  AppStartedEvent event,
  Emitter<SplashOnboardingState> emit,
) async {
  emit(const SplashOnboardingLoading());

  final isCompleted = await _checkStatus();    
  if (!isCompleted) {
    emit(const ShowOnboarding());
    return;
  }

  final isLoggedIn = await _checkLoginStatus();  
  if (isLoggedIn) {
    emit(const NavigateToHome());
  } else {
    emit(const ShowLoginPage());
  }
}

 Future<void> _onOnboardingCompleted(
  OnboardingCompletedEvent event,
  Emitter<SplashOnboardingState> emit,
) async {
  emit(const SplashOnboardingLoading());

  await _completeOnboarding();

  final isLoggedIn = await _checkLoginStatus();
  if (isLoggedIn) {
    emit(const NavigateToHome());
  } else {
    emit(const ShowLoginPage());
  }
}
}
