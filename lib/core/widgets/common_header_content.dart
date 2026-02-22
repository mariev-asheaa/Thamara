import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import '../../generated/locale_keys.g.dart';
import '../color_manager/app_colors.dart';

class CommonHeaderContent extends StatelessWidget {
  final String title;
  final Icon? trailingIcon;
  const CommonHeaderContent({
    super.key,
    required this.title,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
              },
              child: Row(
                children: [
                  Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.whiteColor,
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(LocaleKeys.goBack.tr(), style: TextStyleManager.font16Bold),
                ],
              ),
            ),
            if (trailingIcon != null) trailingIcon!,
          ],
        ),
        SizedBox(height: 15.h),
        Center(child: Text(title, style: TextStyleManager.font26Bold)),
      ],
    );
  }
}
