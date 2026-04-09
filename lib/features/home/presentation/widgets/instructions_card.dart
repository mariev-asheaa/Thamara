import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
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
        boxShadow: [
          BoxShadow(
            color: AppColors.blackColor.withValues(alpha: 0.1),
            blurRadius: 3.06.r,
            offset: Offset(0, 1.02.h),
          ),
        ],
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
                     'assets/images/element.png',

                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Text(
                LocaleKeys.instructionsTitle.tr(),
                style: TextStyleManager.font16Bold.copyWith(
                  color: AppColors.mainBlack,
                ),
              ),
            ],
          ),

          SizedBox(height: 18.h),

           InstructionsItem(text: LocaleKeys.instruction1.tr()),
           InstructionsItem(text: LocaleKeys.instruction2.tr()),
           InstructionsItem(text: LocaleKeys.instruction3.tr()),
           InstructionsItem(text: LocaleKeys.instruction4.tr()),
           InstructionsItem(text: LocaleKeys.instruction5.tr()),
           InstructionsItem(text: LocaleKeys.instruction6.tr()),
           InstructionsItem(text: LocaleKeys.instruction7.tr()),

        ],
      ),
    );
  }
}