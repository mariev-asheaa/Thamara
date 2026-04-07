import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';

class AiConfidenceLevel extends StatelessWidget {
  const AiConfidenceLevel({super.key, required this.title, required this.value, required this.titleStyle, required this.valueStyle});
  final String title;
  final String value;
  final TextStyle titleStyle;
  final TextStyle valueStyle;
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_awesome, size: 14.sp, color: AppColors.primaryColor),
              SizedBox(width: 4.w),
              Text(title, style: titleStyle),
            ],
          ),
          SizedBox(height: 4.h),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}
