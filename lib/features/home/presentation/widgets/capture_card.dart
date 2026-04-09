import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

import '../../../../generated/locale_keys.g.dart';

class CaptureCard extends StatelessWidget {
  final VoidCallback onTap;
  const CaptureCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,

      padding:  EdgeInsets.symmetric(vertical: 32.h, horizontal: 8.w),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("assets/images/capture image.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(32.r),

      ),
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColors.whiteColor.withValues(alpha: 0.2),

              borderRadius: BorderRadius.circular(12.r),

              border: Border.all(
                color: AppColors.whiteColor.withValues(alpha: 0.2),
                width: 1,
              ),
            ),

            child: GestureDetector(
              onTap: onTap,
              child: Center(
                child: SvgPicture.asset("assets/images/camera.svg"),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Text(LocaleKeys.tapToCapture.tr(), style: TextStyleManager.font20Bold),
          Text(
            LocaleKeys.captureHint.tr(),
            style: TextStyleManager.font14Medium.copyWith(
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
