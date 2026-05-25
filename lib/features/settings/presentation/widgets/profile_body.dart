import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/settings/presentation/widgets/personal_info_buttons.dart';
import 'package:thamara/features/settings/presentation/widgets/personal_info_form.dart';

import '../../../../core/widgets/custom_header.dart';
import '../../../../generated/locale_keys.g.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomHeader(
          title: LocaleKeys.personalInfo.tr(),
          showArrow: true,
        ),
        SizedBox(height: 32.h),
        const PersonalInfoForm(),
        SizedBox(height: 24.h),
        const PersonalInfoButtons(),
      ],
    );
  }
}
