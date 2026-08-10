import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/app_bars/custom_app_bar.dart';
import 'package:taskora_app/features/projects/presentation/pages/widgets/app_details_card.dart';
import 'package:taskora_app/features/projects/domain/entities/project_entity.dart';
import 'package:taskora_app/features/projects/presentation/pages/widgets/tasks_empty.dart';

class ProjectDetails extends StatelessWidget {
  const ProjectDetails({super.key, required this.project});
  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Project Details'),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: AppPadding.horizontalPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.name,
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: ColorManager.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.business_outlined,
                      color: ColorManager.textSecondary,
                      size: 18.sp,
                    ),
                    Text(
                      ' client : ${project.client}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: ColorManager.textSecondary,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.textSecondary),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TIME TRACKED',
                        style: TextStyle(
                          height: 1.5,
                          fontSize: 14.sp,
                          color: ColorManager.textSecondary,
                        ),
                      ),
                      Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: Text(
                          '70%',
                          style: TextStyle(
                            height: 0.5,
                            fontSize: 16.sp,
                            color: ColorManager.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            '22 /',
                            style: TextStyle(
                              height: 0.7,
                              fontSize: 22.sp,
                              color: ColorManager.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' 40 hrs',
                            style: TextStyle(
                              height: 1,
                              fontSize: 14.sp,
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
                          // value: project[index] / 100,
                          value: 80 / 100,
                          backgroundColor: ColorManager.borderLight,
                          valueColor: AlwaysStoppedAnimation(
                            ColorManager.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppDetailsCard(
                      icon: Icons.savings_outlined,
                      title: 'title',
                      value: '22',
                    ),
                    SizedBox(width: 16.w),
                    AppDetailsCard(
                      icon: Icons.savings_outlined,
                      title: 'title',
                      value: '333',
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.textSecondary),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: ColorManager.primary,
                          ),
                          Text(
                            ' HOURLY RATE',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: ColorManager.textSecondary,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Text(
                            '\$85 /',
                            style: TextStyle(
                              fontSize: 22.sp,
                              color: ColorManager.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' hrs',
                            style: TextStyle(
                              fontSize: 14.sp,
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
                Text(
                  'Computer overhaul of the main  e- commerce  platform including new checkout flow ,user dashboard integration, and mobile responsiveness improvements .',
                ),
                SizedBox(height: 18.h),
                TasksEmpty(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
