import '../repositories/splash_onboarding_repository.dart';

class LogoutUseCase {
  final SplashOnboardingRepository _repository;

  const LogoutUseCase(this._repository);

  Future<void> call() {
    return _repository.logout();
  }
}
