import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';

class OverlayHeader extends StatelessWidget {
  const OverlayHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.statusWarning,
          child: Icon(Icons.warning_amber_rounded, color: AppColors.statusWarning2, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.disease_detected.tr(),
                style: TextStyleManager.font18SemiBold,
              ),
              Text(
           LocaleKeys.disease_found_desc.tr(),
                style: TextStyleManager.font12Bold.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}