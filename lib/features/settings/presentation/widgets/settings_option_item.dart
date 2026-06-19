import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';

class SettingsOptionItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final String iconPath;
  final VoidCallback onTap;
  final Widget? trailing;

  const SettingsOptionItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.iconPath,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),

        child: Row(
          children: [
            Container(
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Center(
                child: SvgPicture.asset(iconPath, width: 18.w, height: 18.h),
              ),
            ),

            SizedBox(width: 8.w),

            Text(
              title,
              style: TextStyleManager.font16Medium.copyWith(
                color: AppColors.mainBlack,
              ),
            ),

            if (subtitle != null) ...[
              SizedBox(width: 4.w),
              Text(subtitle!, style: TextStyleManager.font12Medium),
            ],

            const Spacer(),

            trailing ?? SvgPicture.asset("assets/images/arrow.svg"),
          ],
        ),
      ),
    );
  }
}
