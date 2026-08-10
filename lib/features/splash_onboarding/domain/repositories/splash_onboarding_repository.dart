abstract class SplashOnboardingRepository {
  Future<bool> isOnboardingCompleted();

  Future<void> setOnboardingCompleted();
  Future<bool> isLoggedIn();

  Future<void> logout();
}
