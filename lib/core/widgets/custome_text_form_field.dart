import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_manager/app_colors.dart';
import '../text_style_manager/text_style_manager.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final double? width;
  final double? height;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.width,
    this.height,
    this.isObscureText,
    this.suffixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 49.h,
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: isObscureText ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),

          hintText: hintText,
          hintStyle: TextStyleManager.font14Medium,

          fillColor: AppColors.backgroundColor,
          filled: true,

          suffixIcon: suffixIcon,

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyColor, width: 1.w),
            borderRadius: BorderRadius.circular(12.r),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.w),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
