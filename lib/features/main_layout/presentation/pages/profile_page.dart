import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/di/service_locator.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/widget/statistic_item_profile.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppPadding.horizontalPagePadding.w,
        child: BlocBuilder<ProjectCubit, ProjectState>(
          builder: (context, state) {
            String projectsCount = '0';

            if (state is ProjectsLoading) {
              return Center(
                child: CircularProgressIndicator(color: ColorManager.primary),
              );
            }

            if (state is ProjectsLoaded) {
              projectsCount = state.projects.length.toString();
            }

            if (state is ProjectsFailure) {
              projectsCount = '0';
            }

            return Column(
              children: [
                CustomAppBar(title: 'Profile'),
                SizedBox(height: 12.h),
                Stack(
                  children: [
                    CircleAvatar(maxRadius: 70),
                    Positioned(
                      top: 90,
                      left: 90,
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        elevation: 3,
                        child: IconButton(
                          onPressed: () {},
                          color: ColorManager.primary,
                          icon: Icon(Icons.drive_file_rename_outline),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'noor jber',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Ux-Ui Designer',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorManager.textSecondary,
                  ),
                ),
                SizedBox(height: 18.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatisticItemProfile(
                      icon: Icons.devices_outlined,
                      value: projectsCount,
                      title: 'PROJECTS',
                    ),
                    StatisticItemProfile(
                      icon: Icons.savings_outlined,
                      value: '55',
                      title: 'WORKING HOURS',
                    ),
                    StatisticItemProfile(
                      icon: Icons.assignment_outlined,
                      value: '\$ 12,340',
                      title: 'TOTAL EARNINGS',
                    ),
                  ],
                ),
                SizedBox(height: 22.h),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorManager.textSecondary,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Account Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hourly Rate'),
                          Text(
                            '\$50/Hour',
                            style: TextStyle(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Member since'),
                          Text(
                            'March2025',
                            style: TextStyle(
                              color: ColorManager.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 22.h),
                InkWell(
                  onTap: () async {
                    final prefs = locator<SharedPreferences>();

                    await prefs.remove('token');
                    await prefs.remove('WatchCost');

                    if (!context.mounted) return;

                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RoutesName.login,
                      (route) => false,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ColorManager.textSecondary,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Material(
                          color: ColorManager.primary,
                          shape: const CircleBorder(),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Icon(Icons.logout, color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Log out',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
