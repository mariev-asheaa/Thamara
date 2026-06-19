import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/features/settings/presentation/widgets/settings_options.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../generated/locale_keys.g.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeader(title: LocaleKeys.navSettings.tr()),
                Column(
                  children: [
                    SizedBox(height: 32.h),
                    SettingsOptions(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
