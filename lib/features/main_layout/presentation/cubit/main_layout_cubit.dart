import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:taskora_app/features/main_layout/presentation/cubit/main_layout_state.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/home_content.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/profile_page.dart';
import 'package:taskora_app/features/projects/presentation/pages/projects_page.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());

  int currentIndex = 0;

  final List<Widget> pages = const [
    HomeContent(),
    ProjectsPage(),
    ProfilePage(),
  ];

  void changeBottomNav(int index) {
    if (index == currentIndex) return;

    currentIndex = index;
    emit(MainLayoutTabChanged(currentIndex));
  }

  void resetToHome() {
    currentIndex = 0;
    emit(MainLayoutTabChanged(currentIndex));
  }
}