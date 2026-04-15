import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';

class SeverityCard extends StatelessWidget {
  const SeverityCard({super.key, required this.severityLevel, required this.severityColor});
  final String severityLevel;
  final Color severityColor;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade200),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.severity_level.tr(),
              style: TextStyleManager.font14Bold.copyWith(color: AppColors.primaryColor),
            ),
            SizedBox(height: 8.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                border: Border.all(color:severityColor),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                severityLevel.isNotEmpty ? severityLevel : "None",
                style: TextStyleManager.font10Bold.copyWith(color: severityColor,
              ),
              ),
            )
          ]
        ),
      ),
    );
  }
}
