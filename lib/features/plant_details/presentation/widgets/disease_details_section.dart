import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/plant_details/data/models/plants_model.dart';
import  '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';

class DiseaseDetailsSection extends StatelessWidget {
  final PlantsModel plantsModel;

  const DiseaseDetailsSection({super.key, required this.plantsModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.diseaseDetails.tr(),
          style: TextStyleManager.font18Bold,
        ),
        SizedBox(height: 16.h),

        Row(
          children: [
            Expanded(
              child: Text(
                LocaleKeys.nameLabel.tr(),
                style: TextStyleManager.font16Medium.copyWith(
                  color: AppColors.mainBlack,
                ),
              ),
            ),
            Expanded(
              child: Text(
                LocaleKeys.firstDetectionDate.tr(),
                style: TextStyleManager.font16Medium.copyWith(
                  color: AppColors.mainBlack,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        Row(
          children: [
            Expanded(
              child: Text(
                plantsModel.diseaseName,
                style: TextStyleManager.font14Medium.copyWith(
                  color: AppColors.neutralGrey500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                plantsModel.firstDetectionDate??'',
                style: TextStyleManager.font14Medium.copyWith(
                  color: AppColors.neutralGrey500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 24.h),
        Text(
          LocaleKeys.diseaseDescription.tr(),
          style: TextStyleManager.font16Medium.copyWith(
            color: AppColors.mainBlack,
          ),
        ),
        SizedBox(height: 8.h),

        Text(
          plantsModel.description,
          style: TextStyleManager.font14Medium.copyWith(
            color: AppColors.neutralGrey500,
            height: 2,
          ),
        ),
      ],
    );
  }
}
