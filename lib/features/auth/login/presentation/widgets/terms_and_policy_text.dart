import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/extentions/navigation.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../generated/locale_keys.g.dart';
import 'custome_text.dart';
import 'package:easy_localization/easy_localization.dart';

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
          children:  [
            CustomText(text: LocaleKeys.policyText.tr()),
            CustomText(text: LocaleKeys.termsOfService.tr(), isColored: true),
            CustomText(text: LocaleKeys.privacyPolicy.tr(), isColored: true),
            CustomText(text: LocaleKeys.andUseOf.tr()),
            CustomText(text: LocaleKeys.cookies.tr(), isColored: true),
          ],
        ),
      ),
    );
  }
}
