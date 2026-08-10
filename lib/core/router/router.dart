import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/di/service_locator.dart';
import 'package:taskora_app/features/auth/presentation/pages/great_new_passwoed.dart';
import 'package:taskora_app/features/auth/presentation/pages/login_page.dart';
import 'package:taskora_app/features/auth/presentation/pages/recover_by_email.dart';
import 'package:taskora_app/features/auth/presentation/pages/signup_page.dart';
import 'package:taskora_app/features/auth/presentation/pages/verification_code_page.dart';
import 'package:taskora_app/features/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/main_layout.dart';
import 'package:taskora_app/features/projects/domain/entities/project_entity.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';
import 'package:taskora_app/features/projects/presentation/pages/create_project.dart';
import 'package:taskora_app/features/projects/presentation/pages/project_details.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/pages/flutter_splash_page.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/pages/onboarding_page.dart';
import 'routers_name.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case RoutesName.onboardingPage:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case RoutesName.flutterSplashPage:
        return MaterialPageRoute(builder: (_) => const FlutterSplashPage());

      case RoutesName.signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case RoutesName.home:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => locator<MainLayoutCubit>()),
              BlocProvider(
                create: (_) => locator<ProjectCubit>()..getProject(),
              ),
            ],
            child: const MainLayout(),
          ),
        );
      case RoutesName.recoverByEmail:
        return MaterialPageRoute(builder: (_) => const RecoverByEmail());
      case RoutesName.verificationCode:
        return MaterialPageRoute(builder: (_) => const VerificationCodePage());
      case RoutesName.greatNewPasswoed:
        return MaterialPageRoute(builder: (_) => const GreatNewPasswoed());
      case RoutesName.projectDetails:
        final project = settings.arguments as ProjectEntity;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => locator<ProjectCubit>(),
            child: ProjectDetails(project: project),
          ),
        );
      case RoutesName.createProject:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => locator<ProjectCubit>(),
            child: const CreateProject(),
          ),
        );

      default:
        return null;
    }
  }
}
