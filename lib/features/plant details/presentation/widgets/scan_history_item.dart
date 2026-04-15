import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/plant%20details/presentation/widgets/app_badge.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/plant_model.dart';

class ScanHistoryItem extends StatelessWidget {
  final ScanRecord record;

  const ScanHistoryItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primaryColor, width: 1.5.w),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              record.image,
              width: 135.w,
              height: 135.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        record.date,
                        style: TextStyleManager.font14Medium.copyWith(
                          color: AppColors.mainBlack,
                        ),
                      ),
                      AppBadge(text: record.severityLevel),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.ai_confidence_level.tr(),
                        style: TextStyleManager.font12Medium.copyWith(
                          color: AppColors.neutralGrey500,
                        ),
                      ),
                      Text(
                        '${(record.confidenceLevel * 100).toInt()}%',
                        style: TextStyleManager.font12Medium.copyWith(
                          color: AppColors.neutralGrey500,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: AppColors.primaryColor.withValues(alpha: 0.25),
                    height: 20.h,
                  ),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      value: record.progress,
                      minHeight: 8.h,
                      backgroundColor: AppColors.whiteColor2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.success,
                      ),
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.recovery.tr(),
                        style: TextStyleManager.font12Medium.copyWith(
                          color: AppColors.neutralGrey500,
                        ),
                      ),
                      Text(
                        '${(record.progress * 100).toInt()}%',
                        style: TextStyleManager.font12Medium.copyWith(
                          color: AppColors.neutralGrey500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
