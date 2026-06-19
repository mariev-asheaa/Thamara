import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/features/settings/presentation/widgets/settings_option_item.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';

class LanguageDropdown extends StatelessWidget {
  final String currentLanguage;
  final ValueChanged<String> onLanguageChanged;

  const LanguageDropdown({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsOptionItem(
      title: LocaleKeys.languageOption.tr(),
      iconPath: 'assets/images/translate.svg',
      onTap: () {},
      trailing: PopupMenuButton<String>(
        offset: Offset(0, 36.h),
        menuPadding: EdgeInsets.zero,
        constraints: BoxConstraints(minWidth: 120.w, maxWidth: 120.w),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        child: Container(
          width: 61.w,
          height: 32.h,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: AppColors.primaryColor.withValues(alpha: 0.20),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentLanguage == 'English' ? 'EN' : 'AR',
                style: TextStyleManager.font16Medium.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              SvgPicture.asset(
                'assets/images/dropButton.svg',
                width: 8.w,
                height: 8.h,
              ),
            ],
          ),
        ),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'English',
              height: 40.h,
              padding: EdgeInsets.zero,
              child: Container(
                height: 40.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
                color: currentLanguage == 'English'
                    ? AppColors.primaryColor.withValues(alpha: 0.20)
                    : AppColors.primaryColor.withValues(alpha: 0.10),
                child: Center(
                  child: Text(
                    LocaleKeys.languageEnglish.tr(),
                    style: TextStyleManager.font16Medium.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
            PopupMenuItem<String>(
              value: 'Arabic',
              height: 40.h,
              padding: EdgeInsets.zero,

              child: Container(
                height: 40.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 8.w),
                color: currentLanguage == 'Arabic'
                    ? AppColors.primaryColor.withValues(alpha: 0.20)
                    : AppColors.primaryColor.withValues(alpha: 0.10),
                child: Center(
                  child: Text(
                    LocaleKeys.languageArabic.tr(),
                    style: TextStyleManager.font16Medium.copyWith(
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        onSelected: (String newValue) {
          if (newValue != currentLanguage) {
            onLanguageChanged(newValue);
          }
        },
      ),
    );
  }
}
