import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/widgets/custome_button.dart';
import '../../../../generated/locale_keys.g.dart';

class NotificationTabFilter extends StatelessWidget {
  final bool isAllSelected;

  final Function(bool) onTabChanged;

  const NotificationTabFilter({
    super.key,
    required this.isAllSelected,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomButton(
            text: LocaleKeys.allTab.tr(),
            backgroundColor: isAllSelected
                ? AppColors.primaryColor
                : AppColors.lightGreen,
            textColor: isAllSelected
                ? AppColors.whiteColor
                : AppColors.primaryColor,
            borderColor: isAllSelected
                ? AppColors.primaryColor
                : AppColors.lightGreen,
            onPressed: () {
              onTabChanged(true);
            },
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: CustomButton(
            text: LocaleKeys.unreadTab.tr(),

            backgroundColor: !isAllSelected
                ? AppColors.primaryColor
                : AppColors.lightGreen,
            textColor: !isAllSelected
                ? AppColors.whiteColor
                : AppColors.primaryColor,
            borderColor: !isAllSelected
                ? AppColors.primaryColor
                : AppColors.lightGreen,

            onPressed: () {
              onTabChanged(false);
            },
          ),
        ),
      ],
    );
  }
}
