import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/di/service_locator.dart';
import 'package:taskora_app/core/router/router.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/core/theme/light_theme.dart';
import 'package:taskora_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora_app/features/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/bloc/splash_onboarding_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(
    MyApp(
      splashBloc: locator<SplashOnboardingBloc>(),
      authBloc: locator<AuthBloc>(),
      mainLayoutCubit: locator<MainLayoutCubit>(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final SplashOnboardingBloc splashBloc;
  final AuthBloc authBloc;
  final MainLayoutCubit mainLayoutCubit;

  const MyApp({
    super.key,
    required this.splashBloc,
    required this.authBloc,
    required this.mainLayoutCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: splashBloc),
        BlocProvider.value(value: authBloc),
        BlocProvider.value(value: mainLayoutCubit),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        // تكييف الخط بناءً على أصغر بُعد
        minTextAdapt: true,
        // دعم تغيير حجم النافذة وتقسيم الشاشة
        splitScreenMode: true,

        builder: (context, child) {
          return MaterialApp(
            onGenerateRoute: AppRouter.generateRoute,
            initialRoute: RoutesName.flutterSplashPage,
            theme: LightTheme.theme,
            debugShowCheckedModeBanner: false,
            title: 'Taskora',
          );
        },
      ),
    );
  }
}
