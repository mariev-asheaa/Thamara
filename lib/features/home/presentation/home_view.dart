import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/features/home/presentation/widgets/capture_card.dart';
import 'package:thamara/features/home/presentation/widgets/instructions_card.dart';

import '../../../core/widgets/custom_divider.dart';
import '../../../core/widgets/custom_header.dart';
import '../../../core/widgets/custome_button.dart';
import '../../../generated/locale_keys.g.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.goodMorning.tr(), style: TextStyleManager.font26Bold),
                  Text('Mohab Mohamed 👋🏻', style: TextStyleManager.font26Bold),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                   SizedBox(height: 24.h),
                  const CaptureCard(),
                  SizedBox(height: 8.h),

                  CustomDivider(themeColor: AppColors.secondaryColor),

                  SizedBox(height: 8.h),
                  CustomButton(
                    text: LocaleKeys.uploadFromGallery.tr(),
                    backgroundColor: AppColors.lightGreen,
                    textColor: AppColors.secondaryColor,
                    icon: SvgPicture.asset('assets/images/gallery.svg'),
                    onPressed: () {},
                  ),
                  SizedBox(height: 24.h),
                  InstructionsCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
