import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/constants/app_assets.dart';
import 'package:thamara/core/extentions/navigation.dart';
import 'package:thamara/features/settings/presentation/widgets/settings_divider.dart';
import 'package:thamara/features/settings/presentation/widgets/settings_option_item.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/color_manager/theme_controller.dart';
import '../../../../core/dependency_injection/di.dart';
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
  late String currentLanguage;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentLanguage = context.locale.languageCode;
  }

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
            iconPath: AppAssets.personalInformation,
            onTap: () {
              context.pushWithNamed(Routes.profileView);
            },
          ),
          const SettingsDivider(),

          LanguageDropdown(
            currentLanguage: currentLanguage,
            onLanguageChanged: (newValue) async {
              setState(() {
                currentLanguage = newValue;
              });

              if (newValue == 'en') {
                await context.setLocale(const Locale('en'));
              } else {
                await context.setLocale(const Locale('ar'));
              }
            },
          ),
          const SettingsDivider(),

          SettingsOptionItem(
            title: LocaleKeys.themeOption.tr(),
            iconPath:AppAssets.theme,
            onTap: () {},
            trailing: SizedBox(
              width: 55.w,
              height: 30.h,
              child: FittedBox(
                fit: BoxFit.fill,
                child: CupertinoSwitch(
                  value: getIt<ThemeController>().isDark,
                  activeTrackColor: AppColors.primaryColor,
                  onChanged: (value) async{
                    setState(() {
                      isDarkMode = value;
                    });
                    await getIt<ThemeController>().toggle(value);
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
