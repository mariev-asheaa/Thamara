import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

import '../../../../core/extentions/navigation.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({super.key});

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
              'assets/images/delete account.svg',
              width: 56.r,
              height: 56.r,
            ),
            SizedBox(height: 16.h),

            Text(
              LocaleKeys.deleteAccountTitle.tr(),
              style: TextStyleManager.font20Bold.copyWith(
                color: AppColors.blackColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),

            Text(
              LocaleKeys.deleteAccountSubtitle.tr(),
              style: TextStyleManager.font16Regular,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    textColor: AppColors.neutralGrey600,
                    text: LocaleKeys.keepAccountBtn.tr(),
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
                    text: LocaleKeys.deleteBtn.tr(),
                    backgroundColor: AppColors.criticalColor,
                    onPressed: () {
                      print("account deleted");
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
