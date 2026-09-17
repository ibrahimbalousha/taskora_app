import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/buttons/custom_text_button.dart';
import 'package:taskora_app/core/config/widgets/states/no_internet_view.dart';
import 'package:taskora_app/core/config/widgets/states/server_error_view.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/widget/app_home_card.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/widget/task_card.dart';
import 'package:taskora_app/features/projects/domain/entities/project_entity.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/presentation/cubit/task_cubit.dart';

bool _isConnectivityError(String message) {
  const connectivityHints = [
    'SocketException',
    'Failed host lookup',
    'Connection refused',
    'Network is unreachable',
    'Connection closed',
    'Connection timed out',
  ];
  return connectivityHints.any(message.contains);
}

Status _statusEnumFor(String status) {
  switch (status) {
    case 'done':
      return Status.done;
    case 'in-progress':
      return Status.inProgress;
    default:
      return Status.toDo;
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(),
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
    );
  }

  Widget _buildWelcomeState(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppPadding.horizontalPagePadding.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(),
            const Spacer(flex: 3),
            Center(
              child: Column(
                children: [
                  Text(
                    'Welcome 👋',
                    style: TextStyle(
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "You haven't added any Projects yet. Start by "
                    'creating your first project.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ColorManager.textSecondary,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            AppElevatedButton(
              label: 'Add Project',
              icon: const Icon(Icons.add, color: Colors.white, size: 18),
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.createProject).then((
                  value,
                ) {
                  if (value == true && context.mounted) {
                    context.read<ProjectCubit>().getProject();
                  }
                });
              },
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingTasks(
    List<TaskEntity> tasks,
    Map<String, String> projectNames,
  ) {
    if (tasks.isEmpty) {
      return Center(
        child: Text(
          'No upcoming tasks',
          style: TextStyle(color: ColorManager.textSecondary, fontSize: 13.sp),
        ),
      );
    }

    return ListView(
      children: tasks
          .take(5)
          .map(
            (task) => TaskCard(
              title: task.name,
              subTitle: projectNames[task.projectId] ?? '',
              status: _statusEnumFor(task.status),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDashboard(List<ProjectEntity> projects) {
    final projectNames = {for (final p in projects) p.id: p.name};
    final projectRates = {for (final p in projects) p.id: p.watchCost};

    return SafeArea(
      child: Padding(
        padding: AppPadding.horizontalPagePadding.w,
        child: Column(
          children: [
            _header(),
            SizedBox(height: 22.h),
            Expanded(
              flex: 14,
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, taskState) {
                  final tasks = taskState is TasksLoaded
                      ? taskState.tasks
                      : const <TaskEntity>[];
                  final completedTasks = tasks.where((t) => t.status == 'done');
                  final completed = completedTasks.length;
                  final remaining = tasks.length - completed;
                  final earnings = completedTasks.fold<num>(
                    0,
                    (sum, t) =>
                        sum + t.totalHours * (projectRates[t.projectId] ?? 0),
                  );

                  final statistics = [
                    StatisticItem(
                      icon: Icons.savings_outlined,
                      title: 'TOTAL EARNINGS',
                      value: '\$ ${earnings.round()}',
                    ),
                    StatisticItem(
                      icon: Icons.devices_outlined,
                      title: 'PROJECTS',
                      value: projects.length.toString(),
                    ),
                    StatisticItem(
                      icon: Icons.fact_check_outlined,
                      title: 'Completed Tasks',
                      value: completed.toString(),
                    ),
                    StatisticItem(
                      icon: Icons.assignment_outlined,
                      title: 'Remaining tasks',
                      value: remaining.toString(),
                    ),
                  ];

                  return GridView.builder(
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
              child: BlocBuilder<TaskCubit, TaskState>(
                builder: (context, taskState) {
                  if (taskState is TasksLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: ColorManager.primary,
                      ),
                    );
                  }

                  final tasks = taskState is TasksLoaded
                      ? taskState.tasks
                      : const <TaskEntity>[];
                  return _buildUpcomingTasks(tasks, projectNames);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProjectCubit, ProjectState>(
      listener: (context, state) {
        if (state is ProjectsLoaded) {
          context.read<TaskCubit>().getAllTasksAcrossProjects(
            state.projects.map((p) => p.id).toList(),
          );
        }
      },
      builder: (context, projectState) {
        if (projectState is ProjectsLoading || projectState is ProjectInitial) {
          return Center(
            child: CircularProgressIndicator(color: ColorManager.primary),
          );
        }

        if (projectState is ProjectsFailure) {
          void retry() => context.read<ProjectCubit>().getProject();

          if (_isConnectivityError(projectState.message)) {
            return NoInternetView(onRetry: retry);
          }

          return ServerErrorView(
            onRetry: retry,
            onContactSupport: () {
              // TODO: wire to a real support email/link once provided.
            },
          );
        }

        final projects = projectState is ProjectsLoaded
            ? projectState.projects
            : const <ProjectEntity>[];

        if (projects.isEmpty) {
          return _buildWelcomeState(context);
        }

        return _buildDashboard(projects);
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
