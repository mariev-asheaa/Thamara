import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';

class SortMenuItem extends PopupMenuItem<String> {
  final String title;
  final String iconPath;

  SortMenuItem({super.key, required this.title, required this.iconPath})
    : super(
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
