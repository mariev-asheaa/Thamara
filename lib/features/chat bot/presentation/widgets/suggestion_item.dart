import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

class SuggestionItem extends StatelessWidget {
  final String text;
  final Function(String) onTap;

  const SuggestionItem({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap:(){ onTap(text);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(500.r),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.2),
              style: BorderStyle.solid,
            ),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyleManager.font14Medium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
