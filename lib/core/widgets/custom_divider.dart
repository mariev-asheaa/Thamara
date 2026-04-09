import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';

import '../text_style_manager/text_style_manager.dart';

class CustomDivider extends StatelessWidget {
  final Color? textColor;
  final Color? lineColor;

  const CustomDivider({
    super.key,
    this.textColor,
    this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Divider(
            color: lineColor ?? AppColors.greyColor,
            thickness: 1,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            "OR",
            style: TextStyleManager.font14Medium.copyWith(
              color: textColor ?? AppColors.greyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        Expanded(
          child: Divider(
            color: lineColor ?? AppColors.greyColor,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}