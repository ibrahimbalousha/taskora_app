import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';
import 'package:taskora_app/features/tasks/domain/entities/task_entity.dart';
import 'package:taskora_app/features/tasks/presentation/cubit/task_cubit.dart';
import '../../domain/entities/project_entity.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});

  final List<ProjectEntity> project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Projects',
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppElevatedButton(
              label: 'Add project',
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.createProject).then((
                  value,
                ) {
                  if (value == true) {
                    context.read<ProjectCubit>().getProject();
                  }
                });
              },
              width: 100,
            ),
          ),
        ],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, taskState) {
          final allTasks = taskState is TasksLoaded
              ? taskState.tasks
              : const <TaskEntity>[];

          return ListView.builder(
            itemCount: project.length,
            itemBuilder: (context, index) {
              final currentProject = project[index];
              final tasks = allTasks
                  .where((t) => t.projectId == currentProject.id)
                  .toList();
              final completedTasks = tasks.where((t) => t.status == 'done');
              final totalHours = tasks.fold<num>(
                0,
                (sum, t) => sum + t.totalHours,
              );
              final doneHours = completedTasks.fold<num>(
                0,
                (sum, t) => sum + t.totalHours,
              );
              final progress = totalHours > 0 ? doneHours / totalHours : 0.0;

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RoutesName.projectDetails,
                    arguments: currentProject,
                  ).then((value) {
                    if (value == true && context.mounted) {
                      context.read<ProjectCubit>().getProject();
                    }
                  });
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.textSecondary),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentProject.name,
                        style: TextStyle(
                          height: 0.7,
                          fontSize: 22,
                          color: ColorManager.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Client : ${currentProject.client}',
                        style: TextStyle(height: 1.5),
                      ),
                      Text('Progress'),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                minHeight: 6,
                                value: progress,
                                backgroundColor: ColorManager.borderLight,
                                valueColor: AlwaysStoppedAnimation(
                                  ColorManager.primary,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '${(progress * 100).round()}%',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 10.w),
                          Icon(
                            Icons.access_time,
                            color: ColorManager.textSecondary,
                            size: 22,
                          ),
                          SizedBox(width: 4.w),

                          Text(
                            '${doneHours.round()}/${totalHours.round()} hrs',
                            style: const TextStyle(
                              fontSize: 16,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                          SizedBox(width: 70.w),

                          Icon(
                            Icons.checklist,
                            color: ColorManager.textSecondary,
                            size: 22,
                          ),
                          SizedBox(width: 4.w),

                          Text(
                            '${completedTasks.length}/${tasks.length} tasks',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff26354F),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
