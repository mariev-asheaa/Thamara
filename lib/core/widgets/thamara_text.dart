import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThamaraText extends StatelessWidget {
  const ThamaraText({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/images/thamara.svg',
      width: 192.w,
      height: 24.h,
    );
  }
}