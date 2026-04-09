import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/home/presentation/widgets/severity_card.dart';
import 'package:thamara/generated/locale_keys.g.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import 'ai_confidence_level.dart';

class DiseaseInfo extends StatelessWidget {
  final String diseaseName;
  final String diseaseDescription;
  final num confidenceLevel;
  final String severityLevel;

  const DiseaseInfo({
    super.key,
    required this.diseaseName,
    required this.diseaseDescription,
    required this.confidenceLevel,
    required this.severityLevel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          diseaseName,
          style: TextStyleManager.font18SemiBold,
        ),
        SizedBox(height: 4.h),
        Text(
          diseaseDescription,
          style: TextStyleManager.font14Medium.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: AiConfidenceLevel(
                title:LocaleKeys.ai_confidence_level.tr(),
                value: "${(confidenceLevel * 100).toStringAsFixed(0)}%",
                titleStyle: TextStyleManager.font14Bold.copyWith(color: AppColors.primaryColor),
                valueStyle: TextStyleManager.font20Bold.copyWith(color: AppColors.mainBlack),
              ),
            ),
            SizedBox(width: 10.w),
            SeverityCard(severityLevel: severityLevel, severityColor: AppColors.statusWarning2)
          ],
        ),
      ],
    );
  }
}
