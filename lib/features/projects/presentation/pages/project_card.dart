import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';
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
      body: ListView.builder(
        itemCount: project.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutesName.projectDetails,
                arguments: project[index],
              );
            },
            onLongPressStart: (details) async {
              final value = await showMenu<String>(
                context: context,
                position: RelativeRect.fromLTRB(
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                ),
                items: [PopupMenuItem(value: "Delete", child: Text("Delete"))],
              );

              if (value == 'Delete') {
                // context.read<ProjectCubit>().deleteProject(
                //   widget.project[index].id,
                // );
              }
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
                    project[index].name,
                    style: TextStyle(
                      height: 0.7,
                      fontSize: 22,
                      color: ColorManager.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Client : ${project[index].client}',
                    style: TextStyle(height: 1.5),
                  ),
                  Text('Progrees'),
                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            minHeight: 6,
                            // value: project[index] / 100,
                            value: 80 / 100,
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
                          '${80 % 100}%',
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
                        // "${project.usedHours} / ${project.totalHours} hrs",
                        "30/40 hrs",
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
                        // "${project.completedTasks}/${project.totalTasks} tasks",
                        "10/20 tasks",
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
      ),
    );

    // return Container(
    //   margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),

    //   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
    //   decoration: BoxDecoration(
    //     color: Colors.white,
    //     borderRadius: BorderRadius.circular(12),
    //     border: Border.all(color: const Color(0xff71809B), width: 1.2),
    //   ),

    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       // Project Name
    //       Text(
    //         project.name,
    //         style: const TextStyle(
    //           fontSize: 22,
    //           fontWeight: FontWeight.w500,
    //           color: Color(0xff596CFF),
    //         ),
    //       ),

    //       // Client
    //       Text(
    //         "Client : ${project.client}",
    //         style: const TextStyle(
    //           height: 1,
    //           fontSize: 14,
    //           color: Color(0xff60718F),
    //         ),
    //       ),

    //       const Text(
    //         "Progress",
    //         style: TextStyle(fontSize: 14, color: Color(0xff60718F)),
    //       ),

    //       Row(
    //         children: [
    //           Expanded(
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(20),
    //               child: LinearProgressIndicator(
    //                 minHeight: 8,
    //                 // value: project.progress / 100,
    //                 value: 80 / 100,

    //                 backgroundColor: const Color(0xffE3E8F2),

    //                 valueColor: const AlwaysStoppedAnimation(Color(0xff596CFF)),
    //               ),
    //             ),
    //           ),

    //           const SizedBox(width: 25),

    //           Text(
    //             // "${project.progress}%",
    //             "80 %",
    //             style: const TextStyle(
    //               fontSize: 22,
    //               fontWeight: FontWeight.bold,
    //               color: Color(0xff202B42),
    //             ),
    //           ),
    //         ],
    //       ),

    //       Row(
    //         children: [
    //           Icon(Icons.access_time, color: Color(0xff60718F), size: 22),

    //           const SizedBox(width: 18),

    //           Text(
    //             // "${project.usedHours} / ${project.totalHours} hrs",
    //             "30 / 40 hrs",
    //             style: const TextStyle(fontSize: 16, color: Color(0xff26354F)),
    //           ),

    //           const SizedBox(width: 60),

    //           Icon(Icons.checklist, color: Color(0xff60718F), size: 22),

    //           const SizedBox(width: 10),

    //           Text(
    //             // "${project.completedTasks}/${project.totalTasks} tasks",
    //             "10 / 20 tasks",
    //             style: const TextStyle(fontSize: 16, color: Color(0xff26354F)),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
