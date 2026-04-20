import 'package:flutter/material.dart';
import 'package:taskora_app/features/auth/presentation/pages/great_new_passwoed.dart';
import 'package:taskora_app/features/auth/presentation/pages/login_page.dart';
import 'package:taskora_app/features/auth/presentation/pages/recover_by_email.dart';
import 'package:taskora_app/features/auth/presentation/pages/signup_page.dart';
import 'package:taskora_app/features/auth/presentation/pages/verification_code_page.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/pages/flutter_splash_page.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/pages/home_page.dart';
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
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RoutesName.recoverByEmail:
        return MaterialPageRoute(builder: (_) => const RecoverByEmail());
      case RoutesName.verificationCode:
        return MaterialPageRoute(builder: (_) => const VerificationCodePage());
          case RoutesName.greatNewPasswoed:
        return MaterialPageRoute(builder: (_) => const GreatNewPasswoed());

      default:
        return null;
    }
  }
}
