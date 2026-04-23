import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../core/widgets/custom_header.dart';
import '../../../../generated/locale_keys.g.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomHeader(title: LocaleKeys.navNotifications.tr()),

        GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/images/mark as read.svg',
                width: 20.w,
                height: 20.h,
              ),
              SizedBox(width: 6.w),
              Text(
                LocaleKeys.markAllRead.tr(),
                style: TextStyleManager.font14Medium.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
