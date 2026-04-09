import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final bool isPrimary;
  final double? width;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? icon;
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.width, this.isLoading=false, this.backgroundColor, this.textColor, this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return  isLoading
        ? const Center(child: CircularProgressIndicator(),)
        : SizedBox(
      width: width ?? double.infinity,
      height: 52.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor:backgroundColor ??( isPrimary
              ? AppColors.primaryColor
              : AppColors.backgroundColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
            side: BorderSide(color:backgroundColor ?? AppColors.primaryColor, width: 1.w),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: TextStyleManager.font16Bold.copyWith(
                color:  textColor ?? (isPrimary ? Colors.white : AppColors.primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
