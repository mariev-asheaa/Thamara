import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/auth/reset_password/presentation/reset_password_view.dart';
import 'package:thamara/core/widgets/auth_header.dart';

import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custome rich_text.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_labeld_field.dart';

class PasswordRecoveryView extends StatelessWidget {
  const PasswordRecoveryView({super.key});

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
                  title: 'Password Recovery',
                  subTitle:
                      'Enter your email to recover your password we\'ll send you an email shortly after...',
                ),

                SizedBox(height: 46.h),

                CustomLabeledField(
                  label: 'Email',
                  hintText: 'example@example.come',
                ),
                SizedBox(height: 8.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomRichText(
                    text: "Didn't Receive one? ",
                    actionText: "Resend",
                    onTap: () {

                    },
                  ),
                ),

                SizedBox(height: 32.h),
                CustomButton(
                  text: 'Recover Password',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordView(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
