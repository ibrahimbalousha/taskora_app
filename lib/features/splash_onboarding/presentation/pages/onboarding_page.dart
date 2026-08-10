import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/constants/image_path.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/buttons/custom_text_button.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/splash_onboarding/presentation/bloc/splash_onboarding_state.dart';

import '../bloc/splash_onboarding_bloc.dart';
import '../bloc/splash_onboarding_event.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _controller = PageController();
  int _index = 0;
  bool get isLast => _index == 2;
  List<Color> onboardingColor = [
    ColorManager.backgroundLight,
    ColorManager.primaryHover,
    ColorManager.primary,
  ];

  void _skip() {
    _controller.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index < 2) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _finish() {
    context.read<SplashOnboardingBloc>().add(const OnboardingCompletedEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashOnboardingBloc, SplashOnboardingState>(
      listener: (context, state) {
        if (state is NavigateToHome) {
          Navigator.of(context).pushReplacementNamed(RoutesName.home);
        } else if (state is ShowLoginPage) {
          Navigator.of(context).pushReplacementNamed(RoutesName.login);
        }
      },
      child: Scaffold(
        body: AnimatedContainer(
          color: onboardingColor[_index],
          duration: const Duration(milliseconds: 250),
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.s2,
                      vertical: AppSizes.s2,
                    ),
                    child: _index < 2
                        ? CustomTextButton(label: 'Skip', onPressed: _skip)
                        : SizedBox(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) => setState(() => _index = value),
                    children: [
                      _OnboardingSlide(
                        title: 'Follow your projects with ease',
                        description:
                            '“Manage all your projects and tasks from one place.”',
                        imagePath: ImagePath.onboarding_1,
                      ),
                      _OnboardingSlide(
                        title: 'Calculate your profits easily',
                        description:
                            '“Record the hours worked for each task and let the app calculate the amount due automatically.”',
                        imagePath: ImagePath.onboarding_2,
                      ),
                      _OnboardingSlide(
                        title: 'Follow your projects with ease',
                        description:
                            '“Manage all your projects and tasks from one place.”',
                        imagePath: ImagePath.onboarding_3,
                        inverted: isLast,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _DotsIndicator(
                          currentIndex: _index,
                          count: 3,
                          inverted: isLast,
                        ),
                        const SizedBox(height: 16),
                        AppElevatedButton(
                          label: _index < 2 ? 'Next' : 'Get Started',
                          onPressed: _index < 2 ? _next : _finish,
                          inverted: _index == 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final bool inverted;

  const _OnboardingSlide({
    required this.title,
    required this.description,
    required this.imagePath,
    this.inverted = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSizes.s12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: Image.asset(imagePath)),
          Text(
            title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 12),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: inverted
                  ? theme.colorScheme.onPrimary.withValues(alpha: 0.85)
                  : ColorManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  final int currentIndex;
  final int count;
  final bool inverted;

  const _DotsIndicator({
    required this.currentIndex,
    required this.count,
    required this.inverted,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final bool active = i == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: active ? 30 : 8,
          decoration: BoxDecoration(
            color: active
                ? (inverted
                      ? theme.colorScheme.onPrimary
                      : theme.colorScheme.primary)
                : (inverted
                      ? theme.colorScheme.onPrimary.withValues(alpha: 0.35)
                      : theme.colorScheme.onSurface.withValues(alpha: 0.2)),

            borderRadius: BorderRadius.circular(999),
          ),
        );
      }),
    );
  }
}
