import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:taskora_app/features/splash_onboarding/data/datasources/splash_onboarding_local_data_source.dart';
import 'package:taskora_app/features/splash_onboarding/data/repositories/splash_onboarding_repository_impl.dart';
import 'package:taskora_app/features/splash_onboarding/domain/usecases/check_onboarding_status_usecase.dart';
import 'package:taskora_app/features/splash_onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/pages/flutter_splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  final localDataSource = SplashOnboardingLocalDataSourceImpl(prefs);
  final repository = SplashOnboardingRepositoryImpl(localDataSource);

  final checkStatus = CheckOnboardingStatusUseCase(repository);
  final completeOnboarding = CompleteOnboardingUseCase(repository);

  final splashOnboardingBloc = SplashOnboardingBloc(
    checkStatus: checkStatus,
    completeOnboarding: completeOnboarding,
  );

  runApp(MyApp(bloc: splashOnboardingBloc));
}

class MyApp extends StatelessWidget {
  final SplashOnboardingBloc bloc;

  const MyApp({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Taskora',
        home: FlutterSplashPage(),
      ),
    );
  }
}
