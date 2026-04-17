import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';

import '../../../../core/text_style_manager/text_style_manager.dart';

class DiagnosticCard extends StatelessWidget {
  final String title;
  final String? iconPath;
  final Widget valueWidget;

  const DiagnosticCard({
    super.key,
    required this.title,
    this.iconPath,
    required this.valueWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.25),
          width: 1.w,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (iconPath != null) ...[
                SvgPicture.asset(iconPath!, width: 15.w, height: 15.h),
                SizedBox(width: 2.w),
              ],
              Text(
                title,
                style: TextStyleManager.font14Medium.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          valueWidget,
        ],
      ),
    );
  }
}
