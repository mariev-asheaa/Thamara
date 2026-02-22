import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/locale_keys.g.dart';
import '../color_manager/app_colors.dart';
import '../text_style_manager/text_style_manager.dart';

class CustomDivider extends StatelessWidget {
  final Color? themeColor;

  const CustomDivider({
    super.key,
    this.themeColor,
  });

  @override
  Widget build(BuildContext context) {

    final Color color = themeColor ?? AppColors.greyColor;

    return Row(
      children: [
        Expanded(
          child: Divider(color: color, thickness: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            LocaleKeys.or.tr(),
            style: TextStyleManager.font12Bold.copyWith(color: color),
          ),
        ),
        Expanded(
          child: Divider(color: color, thickness: 1),
        ),
      ],
    );
  }
}