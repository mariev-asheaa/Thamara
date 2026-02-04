import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/auth/login/presentation/login_view.dart';
import 'package:thamara/core/widgets/auth_header.dart';

import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_labeld_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

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
                  title: 'Reset Password',
                  subTitle:
                      'Create a new password to regain access to your account',
                ),

                SizedBox(height: 46.h),

                CustomLabeledField(
                  label: 'Password',
                  hintText: 'Enter your password...',
                  isObscureText: true,
                ),
                SizedBox(height: 16.h),

                CustomLabeledField(
                  label: 'Confirm Password',
                  hintText: 'Enter your password...',
                  isObscureText: true,
                ),

                SizedBox(height: 32.h),

                CustomButton(
                  text: 'Confirm Password',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginView(),
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
