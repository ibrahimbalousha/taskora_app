import '../repositories/splash_onboarding_repository.dart';

class CompleteOnboardingUseCase {
  final SplashOnboardingRepository _repository;

  const CompleteOnboardingUseCase(this._repository);

  Future<void> call() {
    return _repository.setOnboardingCompleted();
  }
}
