import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/plant_model.dart';
import 'app_badge.dart';
import 'diagnose_card.dart';

class PlantGeneralInfo extends StatelessWidget {
  final PlantModel plant;

  const PlantGeneralInfo({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(plant.name, style: TextStyleManager.font22SemiBold),
        SizedBox(height: 8.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.recoveryProgress.tr(),
              style: TextStyleManager.font14Medium,
            ),
            Text(
              '${(plant.progress * 100).toInt()}%',
              style: TextStyleManager.font20Medium,
            ),
          ],
        ),
        SizedBox(height: 16.h),

        ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: LinearProgressIndicator(
            value: plant.progress,
            minHeight: 14.h,
            backgroundColor: AppColors.whiteColor2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
          ),
        ),

        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: DiagnosticCard(
                title: LocaleKeys.ai_confidence_level.tr(),
                iconPath: 'assets/images/ai.svg',
                valueWidget: Text(
                  '${(plant.confidenceLevel * 100).toInt()}%',
                  style: TextStyleManager.font20Bold.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ),

            SizedBox(width: 16.w),

            Expanded(
              child: DiagnosticCard(
                title: LocaleKeys.severity_level.tr(),
                valueWidget: AppBadge(text: plant.severityLevel),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        Row(
          children: [
            SvgPicture.asset(
              'assets/images/last scan.svg',
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 4.w),
            Text(
              '${LocaleKeys.accordingToLastScan.tr()} ${plant.date}',
              style: TextStyleManager.font14Medium.copyWith(
                color: AppColors.neutralGrey600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
