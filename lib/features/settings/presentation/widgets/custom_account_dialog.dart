import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/constants/app_assets.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

import '../../../../core/extentions/navigation.dart';
import '../../../../core/extentions/on_tap.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';

class CustomAccountDialog extends StatelessWidget {
  const CustomAccountDialog({super.key, required this.title, required this.description, required this.onConfirm, required this.confirmActionButtonText, this.discard});
  final String title;
  final String description;
  final String confirmActionButtonText;
  final VoidCallback onConfirm;
  final String? discard;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      backgroundColor: AppColors.whiteColor,

      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.deleteAccount,
              width: 56.r,
              height: 56.r,
            ),
            SizedBox(height: 16.h),

            Text(
              title,
              style: TextStyleManager.font20Bold.copyWith(
                color: AppColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),

            Text(
             description,
              style: TextStyleManager.font16Regular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    textColor: AppColors.neutralGrey600,
                    text:discard?? LocaleKeys.keepAccountBtn.tr(),
                    isPrimary: false,
                    borderColor: AppColors.neutralGrey600,
                    onPressed: () => context.pop(),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: CustomButton(
                    borderColor: AppColors.criticalColor,
                    textColor: AppColors.whiteColor,
                    text: confirmActionButtonText,
                    backgroundColor: AppColors.criticalColor,
                    onPressed: onConfirm
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
