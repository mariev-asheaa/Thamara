import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/plant_model.dart';

class DiseaseDetailsSection extends StatelessWidget {
  final PlantModel plant;

  const DiseaseDetailsSection({super.key, required this.plant});

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
                plant.diseaseName,
                style: TextStyleManager.font14Medium.copyWith(
                  color: AppColors.neutralGrey500,
                ),
              ),
            ),
            Expanded(
              child: Text(
                plant.firstDetectionDate,
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
          plant.description,
          style: TextStyleManager.font14Medium.copyWith(
            color: AppColors.neutralGrey500,
            height: 2,
          ),
        ),
      ],
    );
  }
}
