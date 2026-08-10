import '../../domain/repositories/splash_onboarding_repository.dart';
import '../datasources/splash_onboarding_local_data_source.dart';

class SplashOnboardingRepositoryImpl implements SplashOnboardingRepository {
  final SplashOnboardingLocalDataSource _local;

  const SplashOnboardingRepositoryImpl(this._local);

  @override
  Future<bool> isOnboardingCompleted() {
    return _local.isOnboardingCompleted();
  }

  @override
  Future<void> setOnboardingCompleted() {
    return _local.setOnboardingCompleted();
  }

  @override
  Future<bool> isLoggedIn() {
    return _local.isLoggedIn();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
