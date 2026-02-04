import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:thamara/core/color_manager/app_colors.dart';

class OtpFields extends StatelessWidget {
  const OtpFields({super.key});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 6,
      keyboardType: TextInputType.number,
      animationType: AnimationType.fade,
      showCursor: true,
      cursorColor: AppColors.secondaryColor,
      cursorHeight: 20,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12.r),
        fieldHeight: 52.h,
        fieldWidth: 52.w,
        activeColor: AppColors.greyColor,
        selectedColor: AppColors.greyColor,
        inactiveColor: AppColors.greyColor,

        activeFillColor: AppColors.backgroundColor,
        inactiveFillColor: AppColors.backgroundColor,
        selectedFillColor: AppColors.backgroundColor,
      ),
      enableActiveFill: true,
      onChanged: (value) {},
      onCompleted: (value) {},
    );
  }
}
