import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/di/service_locator.dart';
import 'package:taskora_app/core/router/router.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/core/theme/light_theme.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(
    MyApp(
      splashBloc: locator<SplashOnboardingBloc>(),
      authBloc: locator<AuthBloc>(),
    ),
  );
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
