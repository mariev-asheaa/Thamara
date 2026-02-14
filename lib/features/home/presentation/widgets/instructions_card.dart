import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import 'instructions_item.dart';

class InstructionsCard extends StatelessWidget {
  const InstructionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Container(
                width: 32.w,
                height: 32.h,
                decoration: BoxDecoration(
                  color: AppColors.lightGreen,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: Image.asset(
                     'assets/images/idea.png',

                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                'How to capture a good photo',
                style: TextStyleManager.font16Bold.copyWith(
                  color: AppColors.mainBlack,
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),

          const InstructionsItem(text: 'Make sure the plant is well-lit'),
          const InstructionsItem(text: 'Avoid shadows over the plant'),
          const InstructionsItem(text: 'Take the photo from a close distance'),
          const InstructionsItem(text: 'Hold the camera steady'),
          const InstructionsItem(text: 'Keep only one plant in the frame'),
          const InstructionsItem(text: 'Ensure the affected area is visible'),
          const InstructionsItem(text: 'Use a clean background if possible'),

        ],
      ),
    );
  }
}