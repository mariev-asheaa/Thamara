import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/home/presentation/widgets/plant_saved_dialog.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';

class SavePlantActionButtons extends StatelessWidget {
  const SavePlantActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Expanded(
          flex: 2,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: AppColors.primaryColor),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              backgroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              LocaleKeys.back.tr(),
              style: TextStyleManager.font16Bold.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteColor,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
              elevation: 0,
            ),
            onPressed: () {
              Navigator.pop(context);
              PlantSavedDialog.show(context);
            },
            child: Text(
              LocaleKeys.save.tr(),
              style: TextStyleManager.font16Bold.copyWith(color: AppColors.whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
