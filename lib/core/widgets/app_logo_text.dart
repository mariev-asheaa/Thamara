import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';

class AppLogoText extends StatelessWidget {
  const AppLogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "THAMARA",
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.primaryColor,
        letterSpacing: 2,
      ),
    );
  }
}