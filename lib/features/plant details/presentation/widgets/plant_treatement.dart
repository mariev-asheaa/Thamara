import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/plant_model.dart';

class PlantTreatment extends StatelessWidget {
  final PlantModel plant;

  const PlantTreatment({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.treatment.tr(),
          style: TextStyleManager.font16Medium.copyWith(
            color: AppColors.mainBlack,
          ),
        ),
        SizedBox(height: 8.h),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColors.primaryColor, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ai.svg',
                    width: 16.w,
                    height: 16.h,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    LocaleKeys.ai_recommendation.tr(),
                    style: TextStyleManager.font14Bold.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              Text(
                plant.treatmentTitle,
                style: TextStyleManager.font14SemiBold,
              ),
              SizedBox(height: 6.h),

              Text(
                '${LocaleKeys.usage.tr()} ${plant.treatmentUsage}',
                style: TextStyleManager.font12Regular.copyWith(
                  color: AppColors.neutralGrey500,
                ),
              ),

              SizedBox(height: 12.h),

              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.statusWarning,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.statusWarning2),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      'assets/images/warning.svg',
                      width: 16.w,
                      height: 16.h,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        LocaleKeys.ai_disclaimer.tr(),
                        style: TextStyleManager.font14Medium.copyWith(
                          color: AppColors.statusWarning2,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
