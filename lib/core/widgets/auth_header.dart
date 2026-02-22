import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../generated/locale_keys.g.dart';
import '../color_manager/app_colors.dart';
import '../text_style_manager/text_style_manager.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subTitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.secondaryColor,
                  size: 18,
                ),
                SizedBox(width: 4.w),

                Text(
                  LocaleKeys.goBack.tr(),
                  style: TextStyleManager.font16Bold.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 23.h),
        Text(
          title,
          style: TextStyleManager.font28Bold,
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
