import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/home/presentation/widgets/save_plant_overlay.dart';

import '../../../../generated/locale_keys.g.dart';

class OverlayActions extends StatelessWidget {
  const OverlayActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:AppColors.lightGreen,
              foregroundColor: AppColors.lightGreen,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            onPressed: () => Navigator.pop(context),
            child:  Text( LocaleKeys.scan_again.tr(), style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.primaryColor)),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          flex: 3,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:AppColors.primaryColor,
              foregroundColor:AppColors.whiteColor,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 16.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
            ),
            onPressed: (){
              SavePlantOverlay.show(context);
            },
            child:  Text( LocaleKeys.continueUse.tr(), style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.whiteColor)),
          ),
        ),
      ],
    );
  }
}
