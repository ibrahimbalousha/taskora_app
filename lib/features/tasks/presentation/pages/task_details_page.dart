import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/buttons/custom_text_button.dart';
import 'package:taskora_app/core/config/widgets/feedback/app_snack_bar.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:taskora_app/features/tasks/presentation/pages/create_task_page.dart';
import 'package:taskora_app/features/tasks/presentation/task_ui_helpers.dart';

class TaskDetailsArgs {
  final TaskEntity task;
  final String projectName;

  const TaskDetailsArgs({required this.task, required this.projectName});
}

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage({super.key, required this.task, required this.projectName});

  final TaskEntity task;
  final String projectName;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  late String _status;

  TaskEntity get task => widget.task;

  @override
  void initState() {
    super.initState();
    _status = task.status;
  }

  bool get _statusChanged => _status != task.status;

  Future<void> _pickStatus() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: taskStatuses
              .map(
                (s) => ListTile(
                  title: Text(s['label']!),
                  trailing: _status == s['value']
                      ? Icon(Icons.check, color: ColorManager.primary)
                      : null,
                  onTap: () => Navigator.pop(context, s['value']),
                ),
              )
              .toList(),
        ),
      ),
    );

    if (selected != null) {
      setState(() => _status = selected);
    }
  }

  void _saveStatus(BuildContext context) {
    context.read<TaskCubit>().updateTask(id: task.id, status: _status);
  }

  Future<void> _editTask(BuildContext context) async {
    final result = await Navigator.pushNamed(
      context,
      RoutesName.createTask,
      arguments: CreateTaskArgs(
        projectId: task.projectId,
        projectName: widget.projectName,
        task: task,
      ),
    );

    if (result == true && context.mounted) {
      Navigator.pop(context, true);
    }
  }

  Future<void> _deleteTask(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Are You Sure ?'),
        content: const Text(
          'This action cannot be undone. This Task and all its associated '
          'comments and files will be permanently removed.',
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

    if (confirmed != true || !context.mounted) return;

    await context.read<TaskCubit>().deleteTask(task.id, task.projectId);

    if (context.mounted) {
      Navigator.pop(context, true);
    }
  }

  Widget _smallInfoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Expanded(
      child: Container(
        height: 80.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.textSecondary, width: 0.5),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20.r, color: valueColor),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(color: ColorManager.textSecondary, fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Center(
              child: Text(
                value,
                style: TextStyle(
                  color: valueColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _wideInfoCard({
    required String label,
    required String value,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
          border: Border.all(color: ColorManager.textSecondary, width: 0.5),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(color: ColorManager.primary, fontSize: 11.sp),
                  ),
                  Text(
                    value,
                    style: TextStyle(
                      color: ColorManager.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskUpdateSuccess) {
          Navigator.pop(context, true);
        } else if (state is TaskUpdateFailure) {
          AppSnackBar.show(context, message: state.message);
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Task Details',
          actions: [
            CustomTextButton(
              label: 'Save',
              onPressed: _statusChanged ? () => _saveStatus(context) : null,
            ),
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppPadding.horizontalPagePaddingAndTop,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.name,
                  style: TextStyle(
                    color: ColorManager.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
                Text(
                  'Project : ${widget.projectName}',
                  style: TextStyle(color: ColorManager.textSecondary, fontSize: 11.sp),
                ),
                SizedBox(height: 18.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.textSecondary, width: 0.5),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          color: ColorManager.textPrimary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        task.description,
                        style: TextStyle(color: ColorManager.textSecondary, fontSize: 13.sp),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _smallInfoCard(
                      icon: Icons.bolt,
                      label: 'PRIORITY',
                      value: taskLabelFor(taskPriorities, task.priority),
                      valueColor: taskPriorityColor(task.priority),
                    ),
                    SizedBox(width: 12.w),
                    _smallInfoCard(
                      icon: Icons.access_time,
                      label: 'ESTIMATED HOURS',
                      value: '${task.totalHours} hrs',
                      valueColor: ColorManager.textPrimary,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                _wideInfoCard(
                  label: 'TASK STATUS',
                  value: taskLabelFor(taskStatuses, _status),
                  trailing: Icon(Icons.keyboard_arrow_down, color: ColorManager.textPrimary),
                  onTap: _pickStatus,
                ),
                SizedBox(height: 12.h),
                _wideInfoCard(label: 'PROJECT', value: widget.projectName),
                SizedBox(height: 24.h),
                Row(
                  children: [
                    Expanded(
                      child: AppElevatedButton(
                        label: 'Edit Task',
                        onPressed: () => _editTask(context),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _deleteTask(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ColorManager.error,
                          side: BorderSide(color: ColorManager.error),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppSizes.r8),
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
        ),
      ),
    );
  }
}
