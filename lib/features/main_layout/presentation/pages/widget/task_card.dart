import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taskora_app/core/config/constants/color_manager.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final Status status;

  const TaskCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: const Border(
          top: BorderSide(color: ColorManager.textSecondary),
          bottom: BorderSide(color: ColorManager.textSecondary),
          left: BorderSide(color: ColorManager.textSecondary),
          right: BorderSide.none,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: ColorManager.primary,
                              height: 0.5,
                            ),
                          ),
                          Text(
                            subTitle,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: ColorManager.textSecondary,
                              height: 1.8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 75.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: status.labelColor),
                        borderRadius: BorderRadius.circular(16.r),
                        color: status.labelBackgroundColor,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        status.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: status.labelColor),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: 18.w,
              decoration: BoxDecoration(
                color: status.sideColor,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum Status { done, inProgress, toDo }

extension StatusExtension on Status {
  String get title {
    switch (this) {
      case Status.done:
        return 'Done';

      case Status.inProgress:
        return 'In Progress';

      case Status.toDo:
        return 'To Do';
    }
  }

  Color get sideColor {
    switch (this) {
      case Status.done:
        return ColorManager.primary;

      case Status.inProgress:
        return ColorManager.error;

      case Status.toDo:
        return ColorManager.warning;
    }
  }

  Color get labelColor {
    switch (this) {
      case Status.done:
        return ColorManager.success;

      case Status.inProgress:
        return ColorManager.warning;

      case Status.toDo:
        return const Color(0xff60718D);
    }
  }

  Color get labelBackgroundColor {
    switch (this) {
      case Status.done:
        return const Color(0xffA4F2C5);

      case Status.inProgress:
        return const Color(0xffFFE5AD);

      case Status.toDo:
        return const Color(0xffDFE7F2);
    }
  }
}
