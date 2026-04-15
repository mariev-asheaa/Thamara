import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color_manager/app_colors.dart';
import '../text_style_manager/text_style_manager.dart';
// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final double? width;
  final double? height;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  TextEditingController controller = TextEditingController();
  final String? Function(String?)? validator;
  final Color? backgroundColor;
  final bool? enabled;
   CustomTextFormField({
    super.key,
    required this.hintText,
    this.width,
    this.height,
    this.isObscureText,
    this.suffixIcon,
     this.prefixIcon,
    this.keyboardType,
     required this.controller,
     this.validator,
     this.backgroundColor,
     this.enabled,

  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 49.h,
      child: TextFormField(
        enabled: enabled ?? true,
        validator: validator,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isObscureText ?? false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 14.h,
          ),
          prefixIcon: prefixIcon,

          hintText: hintText,
          hintStyle: TextStyleManager.font14Medium,

          fillColor:  backgroundColor ?? AppColors.backgroundColor,
          filled: true,

          suffixIcon: suffixIcon,


          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.2),
                width: 1.5.w),
            borderRadius: BorderRadius.circular(12.r),
          ),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5.w),
            borderRadius: BorderRadius.circular(12.r),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.neutralGrey,

                width: 1.5.w),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
      ),
    );
  }
}
