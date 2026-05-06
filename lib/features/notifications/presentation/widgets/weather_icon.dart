import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';

class WeatherIcon extends StatelessWidget {
  const WeatherIcon({super.key, required this.assetPath, required this.label});
final String assetPath;
final String label;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          assetPath,
          width: 14.w,
          height: 14.h,
          colorFilter: ColorFilter.mode(AppColors.greyColor, BlendMode.srcIn),
        ),
        SizedBox(width: 3.w),
        Text(
          label,
          style: TextStyleManager.font10Regular.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
