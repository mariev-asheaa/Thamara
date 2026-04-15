import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';
import 'package:thamara/features/settings/presentation/widgets/settings_option_item.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../generated/locale_keys.g.dart';
import '../views/personal_information_view.dart';

class SettingsOptions extends StatelessWidget {
  const SettingsOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,

        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SettingsOptionItem(
            title: LocaleKeys.personalInfo.tr(),
            iconPath: 'assets/images/personal information.svg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersonalInformationView(),
                ),
              );
            },
          ),

          SettingsOptionItem(
            title: LocaleKeys.languageOption.tr(),
            iconPath: 'assets/images/translate.svg',
            subtitle: LocaleKeys.clickToChange.tr(),
            onTap: () {
              //
            },
          ),

          SettingsOptionItem(
            title: LocaleKeys.themeOption.tr(),
            subtitle: "(Light Mode)",
            iconPath: 'assets/images/theme.svg',
            onTap: () {},
            showDivider: false,
          ),
        ],
      ),
    );
  }
}
