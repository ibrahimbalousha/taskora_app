import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/app_sizes.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';
import 'package:taskora_app/core/config/widgets/buttons/app_elevated_button.dart';

class TasksEmpty extends StatelessWidget {
  const TasksEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: AlignmentGeometry.topLeft,
          child: Text(
            'Tasks',
            style: TextStyle(
              fontSize: AppSizes.fz5,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 22.h),
        Text(
          'No Tasks yet',
          style: TextStyle(
            color: ColorManager.primary,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200.w),
          child: Text(
            'Get Started by adding your first task to this project timeline ',
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 18.h),
        AppElevatedButton(
          label: 'Add Task',
          width: 150,
          onPressed: () {},
          icon: Material(
            color: Colors.white,
            shape: const CircleBorder(),
            child: Icon(Icons.add, color: ColorManager.primary, size: 20),
          ),
        ),
      ],
    );
  }
}
