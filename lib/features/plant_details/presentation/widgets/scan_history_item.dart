import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import  '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/models/scan_record_model.dart';
import 'app_badge.dart';

class ScanHistoryItem extends StatelessWidget {
  final ScanRecord? record;

  const ScanHistoryItem({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    final progressVal = record != null
        ? (record!.progressLevel > 1
            ? record!.progressLevel / 100.0
            : record!.progressLevel.toDouble())
        : 0.0;
    final progressPercent = (progressVal * 100).toInt();

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
            child: Image.network(
              record?.image ?? '',
              width: 135.w,
              height: 135.h,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 135.w,
                height: 135.h,
                color: AppColors.whiteColor2,
                child: Icon(Icons.image_not_supported_outlined,
                    color: AppColors.neutralGrey500),
              ),
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
                        record?.date ?? '',
                        style: TextStyleManager.font14Medium.copyWith(
                          color: AppColors.mainBlack,
                        ),
                      ),
                      // progressStatus is a string badge (e.g. "Healed", "Improving")
                      AppBadge(text: record?.progressStatus ?? ''),
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
                      // confidence is a String like "High" / "Medium" / "Low"
                      Text(
                        record?.confidence ?? '',
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

                  // progressLevel is a double 0.0–1.0
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: LinearProgressIndicator(
                      value: progressVal,
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
                        '$progressPercent%',
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
