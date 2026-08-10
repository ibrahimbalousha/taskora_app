import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/features/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:taskora_app/features/projects/data/datasources/projects_remote_data_source.dart';
import 'package:taskora_app/features/projects/data/repositories_impl/project_repositories_impl.dart';
import 'package:taskora_app/features/projects/domain/repositories/project_repository.dart';
import 'package:taskora_app/features/projects/domain/usecases/get_projects_use_case.dart';
import 'package:taskora_app/features/projects/domain/usecases/project_add_ues_case.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';
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
  // Core dependencies
  final prefs = await SharedPreferences.getInstance();

  locator.registerLazySingleton<SharedPreferences>(() => prefs);

  locator.registerLazySingleton<http.Client>(() => http.Client());

  // Splash Onboarding
  locator.registerLazySingleton<SplashOnboardingLocalDataSource>(
    () => SplashOnboardingLocalDataSourceImpl(locator<SharedPreferences>()),
  );

  locator.registerLazySingleton<SplashOnboardingRepository>(
    () => SplashOnboardingRepositoryImpl(
      locator<SplashOnboardingLocalDataSource>(),
    ),
  );

  locator.registerLazySingleton<CheckOnboardingStatusUseCase>(
    () => CheckOnboardingStatusUseCase(locator<SplashOnboardingRepository>()),
  );

  locator.registerLazySingleton<CompleteOnboardingUseCase>(
    () => CompleteOnboardingUseCase(locator<SplashOnboardingRepository>()),
  );

  locator.registerLazySingleton<CheckLoginStatusUseCase>(
    () => CheckLoginStatusUseCase(locator<SplashOnboardingRepository>()),
  );

  locator.registerFactory<SplashOnboardingBloc>(
    () => SplashOnboardingBloc(
      checkStatus: locator<CheckOnboardingStatusUseCase>(),
      completeOnboarding: locator<CompleteOnboardingUseCase>(),
      checkLoginStatus: locator<CheckLoginStatusUseCase>(),
    ),
  );

  // Auth
  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(client: locator<http.Client>()),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: locator<AuthRemoteDataSource>(),
      sharedPreferences: locator<SharedPreferences>(),
    ),
  );

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

  locator.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: locator<LoginUseCase>(),
      forgotPasswordUseCase: locator<ForgotPasswordUseCase>(),
      verifyResetCodeUseCase: locator<VerifyResetCodeUseCase>(),
      resetPasswordUseCase: locator<ResetPasswordUseCase>(),
      signUpUseCase: locator<SignupUseCase>(),
    ),
  );

  // Projects
  locator.registerLazySingleton<ProjectsRemoteDataSource>(
    () => ProjectsRemoteDataSourceImpl(client: locator<http.Client>()),
  );
  locator.registerLazySingleton<ProjectRepository>(
    () => ProjectRepositoriesImpl(
      remoteDataSource: locator<ProjectsRemoteDataSource>(),
      sharedPreferences: locator<SharedPreferences>(),
    ),
  );

  locator.registerLazySingleton<GetProjectsUseCase>(
    () => GetProjectsUseCase(locator<ProjectRepository>()),
  );
  locator.registerLazySingleton<ProjectAddUesCase>(
    () => ProjectAddUesCase(repositories: locator<ProjectRepository>()),
  );

  locator.registerFactory<ProjectCubit>(
    () => ProjectCubit(
      getProjectsUseCase: locator<GetProjectsUseCase>(),
      projectAddUesCase: locator<ProjectAddUesCase>(),
    ),
  );

  // Main Layout
  locator.registerFactory<MainLayoutCubit>(() => MainLayoutCubit());
}
