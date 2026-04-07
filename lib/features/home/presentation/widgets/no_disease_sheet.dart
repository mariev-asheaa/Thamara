import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/constants/app_assets.dart';
import 'package:thamara/features/home/presentation/widgets/severity_card.dart';
import 'package:thamara/features/home/presentation/widgets/uploaded_image_overlay_display.dart';

import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../data/arguments/ai_feature_arguments.dart';
import 'ai_confidence_level.dart';
import 'overlay_actions.dart';

class NoDiseaseSheet extends StatelessWidget {
  const NoDiseaseSheet({super.key, required this.data, required this.uploadedImagePath});
  final AiFeatureArguments data;
  final String uploadedImagePath;

  static void show(BuildContext context, AiFeatureArguments aiResult, String uploadedImagePath) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      builder: (_) => NoDiseaseSheet(data: aiResult, uploadedImagePath: uploadedImagePath,),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SvgPicture.asset(AppAssets.noDiseaseIcon),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.no_disease_detected.tr(),
                      style: TextStyleManager.font20Bold.copyWith(color: AppColors.mainBlack),
                    ),
                    Text(
                      LocaleKeys.ai_analysis_description.tr(),
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          UploadedImageOverlayDisplay(image: uploadedImagePath),
           SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(child: AiConfidenceLevel(
                title:LocaleKeys.ai_confidence_level.tr(),
                value: "${(data.confidenceLevel * 100).toStringAsFixed(0)}%",
                titleStyle: TextStyleManager.font14Bold.copyWith(color: AppColors.primaryColor),
                valueStyle: TextStyleManager.font20Bold.copyWith(color: AppColors.mainBlack),

              )
              ),
               SizedBox(width: 12.w),
              SeverityCard(severityLevel: data.severityLevel, severityColor: AppColors.secondaryColor2)
            ],
          ),
           SizedBox(height: 20.h),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F7FF),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color:  AppColors.statusBlue),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: AppColors.statusBlue, size: 20),
                 SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    LocaleKeys.monitoring_tip.tr(),
                    style: TextStyleManager.font14Medium.copyWith(color: AppColors.statusBlue),
                  ),
                ),
              ],
            ),
          ),
           SizedBox(height: 24.h),
          OverlayActions()
        ],
      ),
    );
  }
}