import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

import '../extentions/navigation.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  const CustomHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: ()  => context.pop(),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: SvgPicture.asset(
              'assets/images/back arrow.svg',
              width: 10.w,
              height: 14.h,
            ),
          ),
        ),

SizedBox(width: 12.w),
        Text(
          title,
          style: TextStyleManager.font22SemiBold
        ),

      ],
    );
  }
}
