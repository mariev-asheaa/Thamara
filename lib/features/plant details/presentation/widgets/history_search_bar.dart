import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/plant%20details/presentation/widgets/sort_pop_up_menu.dart';
import '../../../../core/widgets/custome_text_form_field.dart';
import '../../../../generated/locale_keys.g.dart';

class HistorySearchBar extends StatelessWidget {
  HistorySearchBar({super.key});

  final TextEditingController temporaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextFormField(
            controller: temporaryController,
            hintText:LocaleKeys.searchHint.tr(),
            prefixIcon: Padding(
              padding: EdgeInsets.all(12.w),
              child: SvgPicture.asset(
                'assets/images/search.svg',
                colorFilter: ColorFilter.mode(
                  AppColors.greyColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),

        SizedBox(width: 8.w),

        const SortPopupMenu(),
      ],
    );
  }
}
