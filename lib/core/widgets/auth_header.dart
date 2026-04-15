import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../generated/locale_keys.g.dart';
import '../color_manager/app_colors.dart';
import '../extentions/navigation.dart';
import '../text_style_manager/text_style_manager.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const AuthHeader({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => context.pop(),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 16.w),
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColors.secondaryColor),
              ),
              child: SvgPicture.asset(
                'assets/images/back arrow.svg',
                width: 10.w,
                height: 14.h,
              ),
            ),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          style: TextStyleManager.font22SemiBold,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.h),
        Text(
          subTitle,
          style: TextStyleManager.font16Medium.copyWith(
            color: AppColors.blackColor,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
