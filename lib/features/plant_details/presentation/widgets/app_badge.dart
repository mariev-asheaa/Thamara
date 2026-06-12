import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';

class AppBadge extends StatelessWidget {
  final String text;

  const AppBadge({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Color color;

    if (text == 'Healed') {
      color = AppColors.success;
    } else if (text == 'Improving'||text == "Low") {
      color = AppColors.improvingColor;
    } else if (text == 'Stable'||text == "Severe") {
      color = AppColors.statusWarning2;
    } else if (text == 'Worsening'||text == "High") {
      color = AppColors.criticalColor;
    } else {
      color = AppColors.greyColor;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(500.r),
        border: Border.all(color: color),
      ),
      child: Text(
        text,
        style: TextStyleManager.font10Bold.copyWith(color: color),
      ),
    );
  }
}
