import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/auth/otp/presentation/widgets/otp_fields.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/auth_header.dart';
import '../../../../core/widgets/custome rich_text.dart';
import '../../../../core/widgets/custome_button.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                SizedBox(height: 16.h),

                const AuthHeader(
                  title: 'Enter Verification Code',
                  subTitle:
                      'We’ve sent a one-time code to your Email. Please enter it below.',
                ),

                SizedBox(height: 46.h),
                const OtpFields(),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomRichText(
                    text: "Didn't Receive one? ",
                    actionText: "Resend",
                    onTap: () {},
                  ),
                ),
                SizedBox(height: 143.h),
                CustomButton(text: 'Confirm OTP', onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
