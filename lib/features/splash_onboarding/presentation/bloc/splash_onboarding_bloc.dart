import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/check_onboarding_status_usecase.dart';
import '../../domain/usecases/complete_onboarding_usecase.dart';
import 'splash_onboarding_event.dart';
import 'splash_onboarding_state.dart';

class SplashOnboardingBloc
    extends Bloc<SplashOnboardingEvent, SplashOnboardingState> {
  final CheckOnboardingStatusUseCase _checkStatus;
  final CompleteOnboardingUseCase _completeOnboarding;

  SplashOnboardingBloc({
    required CheckOnboardingStatusUseCase checkStatus,
    required CompleteOnboardingUseCase completeOnboarding,
  })  : _checkStatus = checkStatus,
        _completeOnboarding = completeOnboarding,
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

    if (isCompleted) {
      emit(const NavigateToHome());
    } else {
      emit(const ShowOnboarding());
    }
  }

  Future<void> _onOnboardingCompleted(
    OnboardingCompletedEvent event,
    Emitter<SplashOnboardingState> emit,
  ) async {
    emit(const SplashOnboardingLoading());

    await _completeOnboarding();

    emit(const NavigateToHome());
  }
}
