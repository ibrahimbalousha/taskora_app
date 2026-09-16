import 'package:shared_preferences/shared_preferences.dart';

import 'splash_onboarding_keys.dart';

abstract class SplashOnboardingLocalDataSource {
  Future<bool> isOnboardingCompleted();
  Future<void> setOnboardingCompleted();
  Future<bool> isLoggedIn();
  Future<void> logout();
}

class SplashOnboardingLocalDataSourceImpl
    implements SplashOnboardingLocalDataSource {
  final SharedPreferences _prefs;

  const SplashOnboardingLocalDataSourceImpl(this._prefs);

  @override
  Future<bool> isOnboardingCompleted() async {
    return _prefs.getBool(SplashOnboardingKeys.onboardingCompleted) ?? false;
  }

  @override
  Future<void> setOnboardingCompleted() async {
    await _prefs.setBool(SplashOnboardingKeys.onboardingCompleted, true);
  }

  @override
  Future<bool> isLoggedIn() async {
    final token = _prefs.getString(SplashOnboardingKeys.token);
    return token != null && token.isNotEmpty;
  }

  @override
  Future<void> logout() async {
    await _prefs.remove(SplashOnboardingKeys.token);
    await _prefs.remove(SplashOnboardingKeys.watchCost);
  }
}
