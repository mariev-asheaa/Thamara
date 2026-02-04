import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/auth/otp/presentation/otp_view.dart';
import 'package:thamara/features/auth/sign_up/presentation/widgets/phone_field.dart';
import 'package:thamara/features/auth/sign_up/presentation/widgets/user_name_field.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/custome rich_text.dart';
import '../../../../core/widgets/thamara_text.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../core/widgets/custome_labeld_field.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

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
                  SizedBox(height: 16.h),
                
                  const AppLogo(),
                
                  SizedBox(height: 24.h),
                
                  const ThamaraText(),
                
                  SizedBox(height: 41.h),
                
                  UserNameFields(),
                  SizedBox(height: 16.h),
                
                  CustomLabeledField(
                    label: 'Email',
                    hintText: 'example@example.come',
                  ),
                
                  SizedBox(height: 16.h),
                
                  const PhoneField(),
                  SizedBox(height: 16.h),
                
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
                  SizedBox(height: 40.h),
                  CustomButton(text: 'Sign Up', onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OtpView(),
                      ),
                    );
                  }),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.center,
                    child: CustomRichText(
                      text: "Already have an account? ",
                      actionText: "Login",
                      onTap: () {

                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      
    );
  }
}
