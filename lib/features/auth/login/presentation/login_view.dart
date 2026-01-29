import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/widgets/app_logo.dart';
import 'package:thamara/core/widgets/thamara_text.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/auth/login/presentation/widgets/terms_and_policy_text.dart';

import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_labeld_field.dart';
import '../../sign_up/presentation/sign_up_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 78.h),
                
                  const Hero(tag: 'logo', child: AppLogo()),
                
                  SizedBox(height: 25.h),
                
                  const Hero(tag: 'app_logo_text', child: ThamaraText()),
                
                  SizedBox(height: 41.h),
                
                  CustomLabeledField(
                    label: 'Username',
                    hintText: 'Enter your username, email, phone number...',
                  ),
                
                  SizedBox(height: 16.h),
                
                  CustomLabeledField(
                    label: 'Password',
                    hintText: 'Enter your password...',
                    isObscureText: true,
                  ),
                  SizedBox(height: 8.h),
                
                  Align(
                    alignment: AlignmentGeometry.bottomLeft,
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyleManager.font14Bold.copyWith(
                          color: AppColors.mainBlack,
                        ),
                      ),
                    ),
                  ),
                
                  SizedBox(height: 40.h),
                  CustomButton(text: 'Sign In', onPressed: () {}),
                  SizedBox(height: 25.h),
                
                  Row(
                    children: [
                      Expanded(
                        child: Divider(color: AppColors.greyColor, thickness: 1),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9),
                        child: Text('OR', style: TextStyleManager.font12Bold),
                      ),
                
                      Expanded(
                        child: Divider(color: AppColors.greyColor, thickness: 1),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                
                  CustomButton(
                    text: 'Create New Account',
                    isPrimary: false,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignUpView()),
                      );
                    },
                  ),
                
                  SizedBox(height: 196.h),
                
                  const TermsAndPolicyText(),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
