import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/generated/locale_keys.g.dart';

import '../../../../core/text_style_manager/text_style_manager.dart';

class TreatmentSection extends StatelessWidget {
  final String treatmentTitle;
  final String treatmentUsage;

  const TreatmentSection({
    super.key,
    required this.treatmentTitle,
    required this.treatmentUsage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.treatment.tr(),
          style: TextStyleManager.font18SemiBold,
        ),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_awesome, size: 16.sp, color: AppColors.primaryColor),
                  SizedBox(width: 6.w),
                  Text(
                    LocaleKeys.ai_recommendation.tr(),
                    style: TextStyleManager.font14Bold.copyWith(color: AppColors.primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                treatmentTitle,
                style: TextStyleManager.font14Bold,
              ),
              if (treatmentUsage.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    treatmentUsage,
                    style: TextStyleManager.font12Bold.copyWith(color: Colors.grey),
                  ),
                ),
              SizedBox(height: 15.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.statusWarning,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.statusWarning2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.warning_amber_rounded, color: AppColors.statusWarning2, size: 18.sp),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        LocaleKeys.ai_disclaimer.tr(),
                         style: TextStyleManager.font14Medium.copyWith(
                          color: AppColors.statusWarning2,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
