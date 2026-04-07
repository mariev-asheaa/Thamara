import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';

class DiseaseInfo extends StatelessWidget {
  const DiseaseInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Powdery Mildew",
          style: TextStyleManager.font18SemiBold,
        ),
        SizedBox(height: 4.h),
        Text(
          "Fungal infection affecting leaf surface and reducing photosynthesis. Early treatment recommended.",
          style: TextStyleManager.font14Medium.copyWith(color: Colors.grey[600]),
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                title: "AI Confidence Level",
                value: "98%",
                titleStyle: TextStyleManager.font14Bold.copyWith(color: AppColors.primaryColor),
                valueStyle: TextStyleManager.font20Bold.copyWith(color: AppColors.mainBlack),
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Severity Level",
                      style: TextStyleManager.font14Bold.copyWith(color: AppColors.primaryColor),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.statusWarning2),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Text(
                        "Medium",
                        style: TextStyleManager.font10Bold.copyWith(color: AppColors.statusWarning2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard({required String title, required String value, required TextStyle titleStyle, required TextStyle valueStyle}) {
    return Container(
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
