import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/constants/app_assets.dart';
import 'package:thamara/features/plant_details/data/models/plants_model.dart';
import 'package:thamara/features/plant_details/data/models/scan_record_model.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import 'app_badge.dart';
import 'diagnose_card.dart';

class PlantGeneralInfo extends StatelessWidget {
  final PlantsModel plantsModel;
  final ScanRecord? latestScan;
  const PlantGeneralInfo({super.key, required this.plantsModel, this.latestScan});

  @override
  Widget build(BuildContext context) {
    final displayDate = latestScan?.date ?? plantsModel.date;
    final double? displayProgress = latestScan != null
        ? (latestScan!.progressLevel > 1
            ? latestScan!.progressLevel / 100.0
            : latestScan!.progressLevel.toDouble())
        : plantsModel.progress;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(plantsModel.name, style: TextStyleManager.font22SemiBold),
        if (displayProgress != null) ...[
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.recoveryProgress.tr(),
                style: TextStyleManager.font14Medium,
              ),
              Text(
                '${(displayProgress * 100).toInt()}%',
                style: TextStyleManager.font20Medium,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: displayProgress,
              minHeight: 14.h,
              backgroundColor: AppColors.whiteColor2,
              color: AppColors.success,
            ),
          ),
        ],

        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: DiagnosticCard(
                title: LocaleKeys.ai_confidence_level.tr(),
                iconPath: AppAssets.aiIcon,
                valueWidget: Text(
                  (plantsModel.confidenceLevel),
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
                valueWidget: AppBadge(text: plantsModel.severityLevel),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        Row(
          children: [
            SvgPicture.asset(
              AppAssets.lastScan,
              width: 20.w,
              height: 20.h,
            ),
            SizedBox(width: 4.w),
            Text(
              '${LocaleKeys.accordingToLastScan.tr()} $displayDate',
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
