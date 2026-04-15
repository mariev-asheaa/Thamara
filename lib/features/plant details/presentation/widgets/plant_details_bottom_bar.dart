import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';

import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';

class PlantDetailsBottomBar extends StatelessWidget {
  const PlantDetailsBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 24.h, bottom: 74, right: 16.w, left: 16.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomButton(
              width: 120.w,
              text: LocaleKeys.uploadBtn.tr(),
              textColor: AppColors.primaryColor,
              icon: ClipRRect(
                child: SvgPicture.asset(
                  'assets/images/upload.svg',
                  width: 20.h,
                  height: 20.h,
                ),
              ),
              backgroundColor: AppColors.lightGreen,
              borderColor: AppColors.lightGreen,
              onPressed: () {},
            ),
          ),

          SizedBox(width: 12.w),

          Expanded(
            child: CustomButton(
              text: LocaleKeys.scan_again.tr(),
              onPressed: () {},
              icon: ClipRRect(
                child: SvgPicture.asset(
                  'assets/images/camera.svg',
                  width: 20.h,
                  height: 20.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
