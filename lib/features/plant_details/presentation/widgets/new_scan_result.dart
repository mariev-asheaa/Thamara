import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/features/plant_details/data/arguments/ai_comparison_arguments.dart';
import 'package:thamara/features/plant_details/presentation/widgets/save_new_scan_buttons.dart';
import 'package:thamara/generated/locale_keys.g.dart';

import '../../../../core/widgets/close_overlay.dart';
import '../../../home/presentation/widgets/ai_confidence_level.dart';

class NewScanResult extends StatelessWidget {
  const NewScanResult({
    super.key,
    required this.imagePath,
    required this.result,
    required this.plantId,
  });

  final String imagePath;
  final AiComparisonArguments result;
  final int plantId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(28.r),
      ),
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      backgroundColor: Colors.white,
      child: Container(
        padding: EdgeInsets.all(20.w),
        constraints: BoxConstraints(
          maxWidth: 400.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CloseOverlay(),
              SizedBox(height: 12.h),

              // Info Banner
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Color(0xffF5FAFF),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.improvingColor, width: 1.w),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: AppColors.improvingColor,
                      size: 20.w,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.newScan.tr(),
                            style: TextStyleManager.font16Bold.copyWith(
                              color: AppColors.improvingColor,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            LocaleKeys.saveDataDesc.tr(),
                            style: TextStyleManager.font14Medium.copyWith(
                              color: AppColors.improvingColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),

              // New scan image
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Image.file(
                  File(imagePath),
                  height: 180.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 16.h),

              // Status Row (AI Confidence & Progress)
              Row(
                children: [
                  // AI Confidence
                  Flexible(
                    child: AiConfidenceLevel(
                      title: LocaleKeys.progress_confidence_level.tr(),
                      value: result.confidence??'High',
                      titleStyle: TextStyleManager.font14Medium,
                      valueStyle: TextStyleManager.font20Bold.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Progress Status
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: AppColors.whiteColor, width: 1.5.w),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleKeys.progressStatus.tr(),
                            style: TextStyleManager.font14Medium,
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(color: AppColors.improvingColor, width: 1.w),
                            ),
                            child: Text(
                              result.progressStatus,
                              style: TextStyleManager.font10Bold.copyWith(
                                color: AppColors.improvingColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),

              // Action Buttons
              SaveNewScanButtons(
                imagePath: imagePath,
                result: result,
                plantId: plantId,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
