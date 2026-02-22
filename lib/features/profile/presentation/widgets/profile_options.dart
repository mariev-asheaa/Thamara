import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/features/profile/presentation/widgets/profile_option_item.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../generated/locale_keys.g.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,

        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.mainBlack.withValues(alpha: 0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainBlack.withValues(alpha: 0.10),
            offset: Offset(0, -1.02.h),
            blurRadius: 2.04.r,
            spreadRadius: -1.02.r,
          ),
          BoxShadow(
            color: AppColors.mainBlack.withValues(alpha: 0.10),
            offset: Offset(0, 1.02.h),
            blurRadius: 3.06.r,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(LocaleKeys.settingsTitle.tr(), style: TextStyleManager.font24Bold),

          SizedBox(height: 24.h),

          ProfileOptionItem(
            title: LocaleKeys.navProfile.tr(),
            iconPath: 'assets/images/user.png',
            onTap: () {
              //
            },
          ),

          ProfileOptionItem(
            title: LocaleKeys.languageOption.tr(),
            iconPath: 'assets/images/languauge.png',
            onTap: () {
              //
            },
          ),

          ProfileOptionItem(
            title: LocaleKeys.dateTimeOption.tr(),
            iconPath: 'assets/images/date&time.png',
            onTap: () {

            },
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
