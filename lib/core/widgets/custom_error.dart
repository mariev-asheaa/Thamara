import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import '../../generated/locale_keys.g.dart';
import '../extentions/on_tap.dart';
import '../text_style_manager/text_style_manager.dart';

class CustomError extends StatelessWidget {
  final String error;

  final void Function() retry;

  const CustomError({super.key, required this.error, required this.retry});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height:15.h),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Container(
              margin:EdgeInsets.symmetric(horizontal: 20.w),
              height: 60.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color:AppColors.criticalColor,
                borderRadius: BorderRadius.circular(16)
              ),
              child: Center(
                child: Text(
                  LocaleKeys.notFoundError.tr(),
                  style: TextStyleManager.font16Medium.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          ).onTap(function: retry),
        ],
      ),
    );
  }
}
