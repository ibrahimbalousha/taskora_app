import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/feedback/app_alert_dialog.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/main_layout/presentation/pages/widget/task_card.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';
import 'package:taskora_app/features/projects/presentation/pages/widgets/app_details_card.dart';
import 'package:taskora_app/features/projects/domain/entities/project_entity.dart';
import 'package:taskora_app/features/projects/presentation/pages/widgets/tasks_empty.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:taskora_app/features/tasks/presentation/pages/create_task_page.dart';
import 'package:taskora_app/features/tasks/presentation/pages/task_details_page.dart';

const List<String> _monthNames = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _formatDeadline(DateTime date) {
  return '${_monthNames[date.month - 1]} ${date.day}, ${date.year}';
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

class ProjectDetails extends StatefulWidget {
  const ProjectDetails({super.key, required this.project});
  final ProjectEntity project;

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  ProjectEntity get project => widget.project;

  // Tracks whether any task was added/edited/deleted during this visit, so
  // that returning to the projects list (and Home's shared task aggregate)
  // knows to refresh even though this page only touches its own local
  // TaskCubit instance.
  bool _tasksChanged = false;

  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getTasks(project.id);
  }

  Future<void> _goToCreateTask() async {
    final result = await Navigator.pushNamed(
      context,
      RoutesName.createTask,
      arguments: CreateTaskArgs(
        projectId: project.id,
        projectName: project.name,
      ),
    );

    if (result == true && mounted) {
      _tasksChanged = true;
      context.read<TaskCubit>().getTasks(project.id);
    }
  }

  Future<void> _goToTaskDetails(TaskEntity task) async {
    final result = await Navigator.pushNamed(
      context,
      RoutesName.taskDetails,
      arguments: TaskDetailsArgs(task: task, projectName: project.name),
    );

    if (result == true && mounted) {
      _tasksChanged = true;
      context.read<TaskCubit>().getTasks(project.id);
    }
  }

  Future<void> _editProject() async {
    final result = await Navigator.pushNamed(
      context,
      RoutesName.createProject,
      arguments: project,
    );

    if (result == true && mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _deleteProject() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Are You Sure ?'),
        content: Text(
          'This action cannot be undone. You are about to permanently '
          'delete the project "${project.name}" and its associated tasks.',
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: ColorManager.error,
              side: BorderSide(color: ColorManager.error),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Delete'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );

    if (confirmed != true || !mounted) return;

    await context.read<ProjectCubit>().deleteProject(project.id);

    if (mounted) Navigator.pop(context, true);
  }

  Future<void> _deleteTask(TaskEntity task) async {
    final confirmed = await AppAlertDialog.confirm(
      context: context,
      title: 'Delete Task',
      message: 'Are you sure you want to delete this task?',
    );

    if (!confirmed || !mounted) return;

    await context.read<TaskCubit>().deleteTask(task.id, project.id);
    _tasksChanged = true;
  }

  Widget _buildTasksSection(List<TaskEntity> tasks) {
    if (tasks.isEmpty) {
      return TasksEmpty(onAddTask: _goToCreateTask);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tasks',
              style: TextStyle(
                fontSize: AppSizes.fz5,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            AppElevatedButton(
              label: 'Add Task',
              width: 110,
              onPressed: _goToCreateTask,
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...tasks.map(
          (task) => GestureDetector(
            onTap: () => _goToTaskDetails(task),
            onLongPress: () => _deleteTask(task),
            child: TaskCard(
              title: task.name,
              subTitle: project.name,
              status: _statusEnumFor(task.status),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, _tasksChanged);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'Project Details'),
        body: SafeArea(
          child: BlocBuilder<TaskCubit, TaskState>(
            builder: (context, taskState) {
              if (taskState is TasksLoading || taskState is TaskInitial) {
                return const Center(
                  child: CircularProgressIndicator(color: ColorManager.primary),
                );
              }

              final tasks = taskState is TasksLoaded
                  ? taskState.tasks
                  : const <TaskEntity>[];

              final totalHours = tasks.fold<num>(
                0,
                (sum, t) => sum + t.totalHours,
              );
              final doneHours = tasks
                  .where((t) => t.status == 'done')
                  .fold<num>(0, (sum, t) => sum + t.totalHours);
              final timeTrackedPercent = totalHours > 0
                  ? doneHours / totalHours
                  : 0.0;
              final budget = project.watchCost * totalHours;

              return SingleChildScrollView(
                child: Padding(
                  padding: AppPadding.horizontalPagePadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: ColorManager.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.business_outlined,
                            color: ColorManager.textSecondary,
                            size: 14.sp,
                          ),
                          SizedBox(width: 3.w),
                          Text(
                            'Client : ${project.client}',
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 14.h),

                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 11.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.textSecondary,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'TIME TRACKED',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                    color: ColorManager.textSecondary,
                                  ),
                                ),
                                Text(
                                  '${(timeTrackedPercent * 100).round()}%',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${doneHours.round()} /',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' ${totalHours.round()} hrs',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: ColorManager.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: LinearProgressIndicator(
                                minHeight: 6,
                                value: timeTrackedPercent.toDouble(),
                                backgroundColor: ColorManager.borderLight,
                                valueColor: AlwaysStoppedAnimation(
                                  ColorManager.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        children: [
                          AppDetailsCard(
                            icon: Icons.calendar_today,
                            title: 'DEADLINE',
                            value: _formatDeadline(project.deadline),
                          ),
                          SizedBox(width: 14.w),
                          AppDetailsCard(
                            icon: Icons.savings_outlined,
                            title: 'BUDGET',
                            value: '\$ ${budget.round()}',
                          ),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorManager.textSecondary,
                            width: 0.5,
                          ),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.credit_card,
                                  color: ColorManager.primary,
                                  size: 20.r,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'HOURLY RATE',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: ColorManager.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '\$${project.watchCost} /',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: ColorManager.primary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' hr',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: ColorManager.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 18.h),

                      Text(
                        'Overview',
                        style: TextStyle(
                          fontSize: AppSizes.fz5,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(project.description),
                      SizedBox(height: 18.h),
                      _buildTasksSection(tasks),
                      SizedBox(height: 24.h),
                      Row(
                        children: [
                          Expanded(
                            child: AppElevatedButton(
                              label: 'Edit Project',
                              onPressed: _editProject,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: _deleteProject,
                              style: OutlinedButton.styleFrom(
                                foregroundColor: ColorManager.error,
                                side: BorderSide(color: ColorManager.error),
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    AppSizes.r8,
                                  ),
                                ),
                              ),
                              child: const Text('Delete'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
