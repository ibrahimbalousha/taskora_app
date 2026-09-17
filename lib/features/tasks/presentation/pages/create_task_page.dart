import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/config/widgets/buttons/custom_text_button.dart';
import 'package:taskora_app/core/config/widgets/feedback/app_snack_bar.dart';
import 'package:taskora_app/core/config/widgets/inputs/app_text_field.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/presentation/cubit/task_cubit.dart';
import 'package:taskora_app/features/tasks/presentation/task_ui_helpers.dart';

class CreateTaskArgs {
  final String projectId;
  final String projectName;
  final TaskEntity? task;

  const CreateTaskArgs({
    required this.projectId,
    required this.projectName,
    this.task,
  });
}

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key, required this.args});

  final CreateTaskArgs args;

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _hoursController;
  late String _priority;
  late String _status;

  bool get _isEdit => widget.args.task != null;

  @override
  void initState() {
    super.initState();
    final task = widget.args.task;
    _nameController = TextEditingController(text: task?.name ?? '');
    _descriptionController = TextEditingController(text: task?.description ?? '');
    _hoursController = TextEditingController(
      text: task != null ? task.totalHours.toString() : '',
    );
    _priority = task?.priority ?? 'medium';
    _status = task?.status ?? 'to-do';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _hoursController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final totalHours = num.tryParse(_hoursController.text.trim()) ?? 0;
    final cubit = context.read<TaskCubit>();

    if (_isEdit) {
      cubit.updateTask(
        id: widget.args.task!.id,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _priority,
        totalHours: totalHours,
        status: _status,
      );
    } else {
      cubit.addTask(
        projectId: widget.args.projectId,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        priority: _priority,
        totalHours: totalHours,
        status: _status,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is TaskAddSuccess || state is TaskUpdateSuccess) {
          Navigator.pop(context, true);
        } else if (state is TaskAddFailure) {
          AppSnackBar.show(context, message: state.message);
        } else if (state is TaskUpdateFailure) {
          AppSnackBar.show(context, message: state.message);
        }
      },
      builder: (context, state) {
        final isLoading = state is TaskAddLoading || state is TaskUpdateLoading;

        return Scaffold(
          appBar: CustomAppBar(
            title: _isEdit ? 'Edit Task' : 'Create Task',
            actions: _isEdit
                ? null
                : [
                    CustomTextButton(
                      label: 'Save',
                      onPressed: isLoading ? null : () => _submit(context),
                    ),
                  ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppPadding.horizontalPagePaddingAndTop,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (!_isEdit) ...[
                      Text(
                        "Let's Start something new! 👋",
                        style: TextStyle(
                          color: ColorManager.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: AppSizes.fz4,
                        ),
                      ),
                      Text(
                        'Create your first tasks to get rolling.',
                        style: TextStyle(color: ColorManager.textSecondary),
                      ),
                      SizedBox(height: 8.h),
                    ],
                    AppTextField(
                      hint: 'What needs to be done?',
                      label: 'Task Name',
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Task name is required';
                        }
                        return null;
                      },
                    ),
                    AppTextField(
                      hint: 'Add details, links, or sub-tasks',
                      label: 'Task Description',
                      controller: _descriptionController,
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Description is required';
                        }
                        return null;
                      },
                    ),
                    if (_isEdit) ...[
                      AppTextField(
                        hint: widget.args.projectName,
                        label: 'Project',
                        enabled: false,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                    ],
                    SizedBox(height: 8.h),
                    Text(
                      'Priority',
                      style: TextStyle(
                        color: ColorManager.textPrimary,
                        fontSize: AppSizes.fz3,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: taskPriorities.map((p) {
                        final selected = _priority == p['value'];
                        final color = taskPriorityColor(p['value']!);
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () => setState(() => _priority = p['value']!),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: selected
                                    ? color.withValues(alpha: 0.12)
                                    : Colors.transparent,
                                border: Border.all(
                                  color: selected ? color : ColorManager.borderLight,
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.circle, size: 8, color: color),
                                  const SizedBox(width: 6),
                                  Text(
                                    p['label']!,
                                    style: TextStyle(
                                      color: selected ? color : ColorManager.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AppTextField(
                            hint: '1',
                            label: 'Est. Hours',
                            controller: _hoursController,
                            keyboardType: TextInputType.number,
                            prefixIcon: const Icon(Icons.access_time),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Required';
                              }
                              if (num.tryParse(value.trim()) == null) {
                                return 'Invalid';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: AppSizes.s2),
                                child: Text(
                                  'Status',
                                  style: TextStyle(
                                    color: ColorManager.textPrimary,
                                    fontSize: AppSizes.fz3,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              DropdownButtonFormField<String>(
                                initialValue: _status,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(color: ColorManager.primary),
                                  ),
                                ),
                                items: taskStatuses
                                    .map(
                                      (s) => DropdownMenuItem(
                                        value: s['value'],
                                        child: Text(s['label']!),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (value) {
                                  if (value != null) setState(() => _status = value);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    AppElevatedButton(
                      label: _isEdit ? 'Save Changes' : 'Create Task',
                      isLoading: isLoading,
                      onPressed: isLoading ? null : () => _submit(context),
                    ),
                    if (_isEdit) ...[
                      SizedBox(height: 12.h),
                      AppElevatedButton(
                        label: 'Cancel',
                        inverted: true,
                        onPressed: isLoading ? null : () => Navigator.pop(context),
                      ),
                    ],
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
