
import 'package:taskora_app/features/splash_onboarding/domain/repositories/splash_onboarding_repository.dart';

class CheckLoginStatusUseCase {
  final SplashOnboardingRepository _repository;

  const CheckLoginStatusUseCase(this._repository);

  Future<bool> call() async {
    return await _repository.isLoggedIn();
  }
}