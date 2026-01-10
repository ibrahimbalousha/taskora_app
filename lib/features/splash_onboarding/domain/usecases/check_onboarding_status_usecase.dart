import '../repositories/splash_onboarding_repository.dart';

class CheckOnboardingStatusUseCase {
  final SplashOnboardingRepository _repository;

  const CheckOnboardingStatusUseCase(this._repository);

  Future<bool> call() {
    return _repository.isOnboardingCompleted();
  }
}
