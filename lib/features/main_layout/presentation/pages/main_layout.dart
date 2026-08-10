import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora_app/features/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:taskora_app/features/main_layout/presentation/cubit/main_layout_state.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/widget/custom_nav.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainLayoutCubit, MainLayoutState>(
      builder: (context, state) {
        final cubit = context.read<MainLayoutCubit>();

        return Scaffold(
          extendBody: true,
          body: IndexedStack(index: cubit.currentIndex, children: cubit.pages),
          bottomNavigationBar: CustomNav(
            currentIndex: cubit.currentIndex,
            onTap: cubit.changeBottomNav,
          ),
        );
      },
    );
  }
}
