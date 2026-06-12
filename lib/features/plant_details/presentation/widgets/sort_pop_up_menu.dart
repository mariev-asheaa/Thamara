import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/constants/app_assets.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

import '../../../../generated/locale_keys.g.dart';

class SortPopupMenu extends StatelessWidget {
  const SortPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: AppColors.backgroundColor,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        dividerTheme: DividerThemeData(
          color: AppColors.primaryColor.withValues(alpha: 0.25),
          thickness: 1.w,
        ),
      ),
      child: PopupMenuButton<String>(
        offset: Offset(0, 58.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(
            color: AppColors.primaryColor.withValues(alpha: 0.25),
            width: 1.5.w,
          ),
        ),
        child: Container(
          height: 52.h,
          width: 52.w,
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.25),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: SvgPicture.asset(AppAssets.filter),
          ),
        ),
        itemBuilder: (context) => [
          buildMenuItem(LocaleKeys.sortNewest.tr(), 'assets/images/newest.svg'),
          const PopupMenuDivider(),
          buildMenuItem(LocaleKeys.sortOldest.tr(), 'assets/images/oldest.svg'),
          const PopupMenuDivider(),
          buildMenuItem(LocaleKeys.sortAToZ.tr(), 'assets/images/newest.svg'),
          const PopupMenuDivider(),
          buildMenuItem(LocaleKeys.sortZToA.tr(), 'assets/images/oldest.svg'),
        ],
        onSelected: (value) {
          print("Selected: $value");
        },
      ),
    );
  }

  PopupMenuItem<String> buildMenuItem(String title, String iconPath) {
    return PopupMenuItem<String>(
      value: title,
      height: 40.h,
      child: Row(
        children: [
          SvgPicture.asset(iconPath, width: 18.w),
          SizedBox(width: .5.w),
          Text(
            title,
            style: TextStyleManager.font14Regular.copyWith(
              color: AppColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }
}
