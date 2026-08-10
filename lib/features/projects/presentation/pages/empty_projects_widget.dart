import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/core/router/routers_name.dart';
import 'package:taskora_app/features/projects/presentation/cubit/project_cubit.dart';

class EmptyProjectsWidget extends StatelessWidget {
  const EmptyProjectsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'projects', centerTitle: false),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.horizontalPagePadding.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'No project yet',
                      style: TextStyle(
                        color: ColorManager.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 200.w),
                      child: Text(
                        'Projects help you organize your work and track progress',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 18.h),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.createProject,
                        ).then((value) {
                          if (value == true) {
                           
                              context.read<ProjectCubit>().getProject();
                           
                          }
                        });
                      },
                      child: DottedBorder(
                        options: const RoundedRectDottedBorderOptions(
                          color: ColorManager.primary,
                          strokeWidth: 2,
                          dashPattern: [12, 12],
                          radius: Radius.circular(12),
                        ),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Material(
                                color: ColorManager.primary,
                                shape: const CircleBorder(),
                                child: Icon(Icons.add, color: Colors.white),
                              ),
                              SizedBox(width: 12.w),
                              Text(
                                'Create Project ',
                                style: TextStyle(
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
