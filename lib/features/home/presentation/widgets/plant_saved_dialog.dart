import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../generated/locale_keys.g.dart';

class PlantSavedDialog extends StatelessWidget {
  const PlantSavedDialog({super.key});
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // Dismiss by clicking outside
      builder: (context) => Dialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w), // Distance from screen edges
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: const PlantSavedDialog(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.close, color: Colors.black),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
          SizedBox(height: 10.h),
         SvgPicture.asset(AppAssets.savedSuccessfully),
          SizedBox(height: 16.h),
          Text(
            LocaleKeys.saved_title.tr(),
            style: TextStyleManager.font20Bold.copyWith(
              color: AppColors.mainBlack,
            ),
          ),
          SizedBox(height: 12.h),

          // --- DESCRIPTION TEXT ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              LocaleKeys.saved_success_msg.tr(),
              textAlign: TextAlign.center,
              style: TextStyleManager.font14Regular.copyWith(
                color: AppColors.blackColor
              ),
            ),
          ),
          SizedBox(height: 24.h),

          Row(
            children: [
              Expanded(
                flex: 3,
                child:
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.whiteColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                    elevation: 0, // Flat design
                  ),
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isCurrent);
                  },
                  child: Text(
                    LocaleKeys.back_to_home.tr(),
                    style: TextStyleManager.font16Bold.copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // "View Plant" button (Light background)
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightGreen,
                    foregroundColor: AppColors.lightGreen,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                    elevation: 0, // Flat design
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    LocaleKeys.view_plant.tr(),
                    style: TextStyleManager.font16Bold.copyWith(color: AppColors.primaryColor),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h), // Bottom padding
        ],
      ),
    );
  }
}