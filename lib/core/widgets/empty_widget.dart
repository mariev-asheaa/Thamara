import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import '../../generated/locale_keys.g.dart';
import '../text_style_manager/text_style_manager.dart';

class CustomEmptyWidget extends StatelessWidget {
  final String title;
  final String subTitle;

  const CustomEmptyWidget({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: SvgPicture.asset(
              'assets/images/cancel.svg',
              width: 24.w,
              height: 24.h,
            ),
          ),

          SizedBox(height: 12.h),

          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyleManager.font16SemiBold,
          ),

          SizedBox(height: 6.h),

          Text(
            subTitle,
            textAlign: TextAlign.center,
            style: TextStyleManager.font16Regular,
          ),

          SizedBox(height: 32.h),

          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.goToHome.tr(),
                  style: TextStyleManager.font16Bold.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(width: 12.w),
                SvgPicture.asset(
                  'assets/images/forward arrow.svg',
                  width: 24.w,
                  height: 24.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
