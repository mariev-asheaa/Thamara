import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          SizedBox(height: 16.h),

          Container(
            width: 64.w,
            height: 64.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.gradient2, AppColors.gradient1],
              ),
            ),
            child: Center(
              child: SvgPicture.asset(
                'assets/images/chatbot.svg',
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          SizedBox(height: 18.h),

          Text(
            "Welcome to Plant Expert AI",
            textAlign: TextAlign.center,
            style: TextStyleManager.font16Medium.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 9.h),

          Text(
            "Your personal plant knowledge assistant! Ask me anything about plants, upload photos for identification, or get care advice.",
            textAlign: TextAlign.center,
            style: TextStyleManager.font16Medium,
          ),
        ],
      ),
    );
  }
}
