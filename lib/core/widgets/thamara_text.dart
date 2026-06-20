import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/constants/app_assets.dart';

class ThamaraText extends StatelessWidget {
  const ThamaraText({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.thamara,
      width: 192.w,
      height: 24.h,
    );
  }
}