abstract class SplashOnboardingRepository {
  /// Returns true if onboarding was completed before.
  Future<bool> isOnboardingCompleted();

  /// Persists onboarding completion.
  Future<void> setOnboardingCompleted();
}
