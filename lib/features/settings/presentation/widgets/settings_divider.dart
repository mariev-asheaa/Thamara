import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 12.h),
        Divider(
          thickness: 1,
          color: AppColors.primaryColor.withValues(alpha: 0.25),
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
