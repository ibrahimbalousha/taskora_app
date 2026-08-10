import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/buttons/custom_text_button.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/widget/app_home_card.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/widget/task_card.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectCubit, ProjectState>(
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

        final List<StatisticItem> statistics = [
          StatisticItem(
            icon: Icons.savings_outlined,
            title: 'TOTAL EARNINGS',
            value: '\$ 12,340',
          ),
          StatisticItem(
            icon: Icons.devices_outlined,
            title: 'PROJECTS',
            value: projectsCount,
          ),
          StatisticItem(
            icon: Icons.fact_check_outlined,
            title: 'Completed Tasks',
            value: '48',
          ),
          StatisticItem(
            icon: Icons.assignment_outlined,
            title: 'Remaining tasks',
            value: '24',
          ),
        ];

        return SafeArea(
          child: Padding(
            padding: AppPadding.horizontalPagePadding.w,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(),
                        SizedBox(width: 12.w),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'noor jber',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.sp,
                                  height: 1,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                'Ux-Ui Designer',
                                style: TextStyle(
                                  // fontWeight: FontWeight.bold,
                                  fontSize: 12.sp,
                                  height: 1.8,
                                  color: ColorManager.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications_none_outlined, size: 22.r),
                    ),
                  ],
                ),
                SizedBox(height: 22.h),
                Expanded(
                  flex: 14,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 10.h,
                      mainAxisExtent: 85.h,
                    ),
                    itemCount: statistics.length,
                    itemBuilder: (context, index) {
                      return AppHomeCard(
                        icon: statistics[index].icon,
                        title: statistics[index].title,
                        value: statistics[index].value,
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upcoming Tasks',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          color: ColorManager.textPrimary,
                        ),
                      ),

                      CustomTextButton(label: 'See All', onPressed: () {}),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Expanded(
                  flex: 20,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TaskCard(
                        title: 'Design Home Screen',
                        subTitle: 'Freelancer App',
                        status: Status.done,
                      ),
                      TaskCard(
                        title: 'Design Home Screen',
                        subTitle: 'Freelancer App',
                        status: Status.inProgress,
                      ),
                      TaskCard(
                        title: 'Design Home Screen',
                        subTitle: 'Freelancer App',
                        status: Status.toDo,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class StatisticItem {
  final IconData icon;
  final String title;
  final String value;

  const StatisticItem({
    required this.icon,
    required this.title,
    required this.value,
  });
}
