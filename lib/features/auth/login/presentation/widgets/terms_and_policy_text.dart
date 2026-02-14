import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extentions/navigation.dart';
import '../../../../../core/routing/routes.dart';
import 'custome_text.dart';

class TermsAndPolicyText extends StatelessWidget {
  const TermsAndPolicyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 16.h),
      child: GestureDetector(
        onTap: (){
          context.pushWithNamed(Routes.homeView);
        },
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 3.w,
          runSpacing: 1.h,
          children: const [
            CustomText(text: 'By signing up, you accept our'),
            CustomText(text: 'Terms of Service,', isColored: true),
            CustomText(text: 'Privacy Policy,', isColored: true),
            CustomText(text: 'and use of'),
            CustomText(text: 'Cookies', isColored: true),
          ],
        ),
      ),
    );
  }
}
