import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/core/router/router.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/core/theme/light_theme.dart';
import 'package:taskora_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:taskora_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:taskora_app/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/signup_usecase.dart';
import 'package:taskora_app/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';

import 'package:taskora_app/features/splash_onboarding/data/datasources/splash_onboarding_local_data_source.dart';
import 'package:taskora_app/features/splash_onboarding/data/repositories/splash_onboarding_repository_impl.dart';
import 'package:taskora_app/features/splash_onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'package:taskora_app/features/splash_onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  /// Splash dependencies
  final localDataSource = SplashOnboardingLocalDataSourceImpl(prefs);
  final repository = SplashOnboardingRepositoryImpl(localDataSource);

  final checkStatus = CheckOnboardingStatusUseCase(repository);
  final completeOnboarding = CompleteOnboardingUseCase(repository);

  final splashOnboardingBloc = SplashOnboardingBloc(
    checkStatus: checkStatus,
    completeOnboarding: completeOnboarding,
  );

  /// Auth dependencies
  final authRemote = AuthRemoteDataSourceImpl();
  final authRepo = AuthRepositoryImpl(remoteDataSource: authRemote);

  final authBloc = AuthBloc(
    loginUseCase: LoginUseCase(authRepo),
    forgotPasswordUseCase: ForgotPasswordUseCase(authRepo),
    verifyResetCodeUseCase: VerifyResetCodeUseCase(authRepo),
    resetPasswordUseCase: ResetPasswordUseCase(authRepo),
    signUpUseCase: SignupUseCase(authRepo),
  );

  runApp(MyApp(splashBloc: splashOnboardingBloc, authBloc: authBloc));
}

class MyApp extends StatelessWidget {
  final SplashOnboardingBloc splashBloc;
  final AuthBloc authBloc;

  const MyApp({super.key, required this.splashBloc, required this.authBloc});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: splashBloc),
        BlocProvider.value(value: authBloc),
      ],
      child: MaterialApp(
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: RoutesName.flutterSplashPage,
        theme: LightTheme.theme,
        debugShowCheckedModeBanner: false,
        title: 'Taskora',
      ),
    );
  }
}
