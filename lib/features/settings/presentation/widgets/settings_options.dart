import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/extentions/navigation.dart';
import 'package:thamara/features/settings/presentation/widgets/settings_divider.dart';
import 'package:thamara/features/settings/presentation/widgets/settings_option_item.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/routing/routes.dart';
import '../../../../generated/locale_keys.g.dart';
import 'language_dropdown.dart';

class SettingsOptions extends StatefulWidget {
  const SettingsOptions({super.key});

  @override
  State<SettingsOptions> createState() => _SettingsOptionsState();
}

class _SettingsOptionsState extends State<SettingsOptions> {
  bool isDarkMode = false;
  String currentLanguage = 'English';

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
              context.pushWithNamed(Routes.profileView);
            },
          ),
          const SettingsDivider(),

          LanguageDropdown(
            currentLanguage: currentLanguage,
            onLanguageChanged: (newValue) {
              setState(() {
                currentLanguage = newValue;
              });
            },
          ),
          const SettingsDivider(),

          SettingsOptionItem(
            title: LocaleKeys.themeOption.tr(),
            iconPath: 'assets/images/theme.svg',
            onTap: () {},
            trailing: SizedBox(
              width: 55.w,
              height: 30.h,
              child: FittedBox(
                fit: BoxFit.fill,
                child: CupertinoSwitch(
                  value: isDarkMode,
                  activeTrackColor: AppColors.primaryColor,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
