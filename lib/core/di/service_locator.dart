import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/features/splash_onboarding/domain/usecases/check_login_status_usecase.dart';

import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/forgot_password_usecase.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/reset_password_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/domain/usecases/verify_reset_code_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/splash_onboarding/data/datasources/splash_onboarding_local_data_source.dart';
import '../../features/splash_onboarding/data/repositories/splash_onboarding_repository_impl.dart';
import '../../features/splash_onboarding/domain/repositories/splash_onboarding_repository.dart';
import '../../features/splash_onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import '../../features/splash_onboarding/domain/usecases/complete_onboarding_usecase.dart';
import '../../features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

final GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  locator.registerLazySingleton<SharedPreferences>(() => prefs);

  // Splash Onboarding
  // ========================
  // DataSource
  locator.registerLazySingleton<SplashOnboardingLocalDataSource>(
    () => SplashOnboardingLocalDataSourceImpl(locator<SharedPreferences>()),
  );

  // Repository
  locator.registerLazySingleton<SplashOnboardingRepository>(
    () => SplashOnboardingRepositoryImpl(
      locator<SplashOnboardingLocalDataSource>(),
    ),
  );

  // UseCases
  locator.registerLazySingleton<CheckOnboardingStatusUseCase>(
    () => CheckOnboardingStatusUseCase(locator<SplashOnboardingRepository>()),
  );
  locator.registerLazySingleton<CompleteOnboardingUseCase>(
    () => CompleteOnboardingUseCase(locator<SplashOnboardingRepository>()),
  );
  locator.registerLazySingleton<CheckLoginStatusUseCase>(
    () => CheckLoginStatusUseCase(locator<SplashOnboardingRepository>()),
  );

  // Bloc
  locator.registerFactory<SplashOnboardingBloc>(
    () => SplashOnboardingBloc(
      checkStatus: locator<CheckOnboardingStatusUseCase>(),
      completeOnboarding: locator<CompleteOnboardingUseCase>(),
      checkLoginStatus: locator<CheckLoginStatusUseCase>(),
    ),
  );

  // Auth
  // ========================
  // Remote DataSource
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  // Repository
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: locator<AuthRemoteDataSource>()),
  );

  // UseCases
  locator.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<ForgotPasswordUseCase>(
    () => ForgotPasswordUseCase(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<VerifyResetCodeUseCase>(
    () => VerifyResetCodeUseCase(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<ResetPasswordUseCase>(
    () => ResetPasswordUseCase(locator<AuthRepository>()),
  );
  locator.registerLazySingleton<SignupUseCase>(
    () => SignupUseCase(locator<AuthRepository>()),
  );

  // Bloc
  locator.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: locator<LoginUseCase>(),
      forgotPasswordUseCase: locator<ForgotPasswordUseCase>(),
      verifyResetCodeUseCase: locator<VerifyResetCodeUseCase>(),
      resetPasswordUseCase: locator<ResetPasswordUseCase>(),
      signUpUseCase: locator<SignupUseCase>(),
    ),
  );
}
