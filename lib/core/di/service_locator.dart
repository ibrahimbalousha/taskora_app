import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/domain/usecases/verify_reset_code_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/splash_onboarding/data/datasources/splash_onboarding_local_data_source.dart';
import '../../features/splash_onboarding/data/repositories/splash_onboarding_repository_impl.dart';
import '../../features/splash_onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import '../../features/splash_onboarding/domain/usecases/complete_onboarding_usecase.dart';
import '../../features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => prefs);

  /// Splash dependencies
  locator.registerLazySingleton(() => SplashOnboardingLocalDataSourceImpl(locator()));
  locator.registerLazySingleton(() => SplashOnboardingRepositoryImpl(locator()));
  locator.registerLazySingleton(() => CheckOnboardingStatusUseCase(locator()));
  locator.registerLazySingleton(() => CompleteOnboardingUseCase(locator()));
  locator.registerFactory(() => SplashOnboardingBloc(
        checkStatus: locator(),
        completeOnboarding: locator(),
      ));

  /// Auth dependencies
  locator.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
  locator.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl(remoteDataSource: locator()));
  locator.registerLazySingleton(() => LoginUseCase(locator()));
  locator.registerLazySingleton(() => ForgotPasswordUseCase(locator()));
  locator.registerLazySingleton(() => VerifyResetCodeUseCase(locator()));
  locator.registerLazySingleton(() => ResetPasswordUseCase(locator()));
  locator.registerLazySingleton(() => SignupUseCase(locator()));
  locator.registerFactory(() => AuthBloc(
        loginUseCase: locator(),
        forgotPasswordUseCase: locator(),
        verifyResetCodeUseCase: locator(),
        resetPasswordUseCase: locator(),
        signUpUseCase: locator(),
      ));
}