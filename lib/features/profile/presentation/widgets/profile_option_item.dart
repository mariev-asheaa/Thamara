import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';

class ProfileOptionItem extends StatelessWidget {
  final String title;
  final String iconPath;
  final VoidCallback onTap;
  final bool showDivider;

  const ProfileOptionItem({
    super.key,
    required this.title,
    required this.iconPath,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
          leading: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(child: Image.asset(iconPath)),
          ),
          title: Text(
            title,
            style: TextStyleManager.font16Medium.copyWith(
              color: AppColors.mainBlack,
            ),
          ),
          trailing: SvgPicture.asset("assets/images/arrow.svg"),
        ),

        if (showDivider) Column(
          children: [
            SizedBox(height: 16.h),


            Divider(
              height: 1.h,
              thickness: 1,
              color: AppColors.mainBlack.withValues(alpha: 0.2),
            ),
          ],
        ),
      ],
    );
  }
}