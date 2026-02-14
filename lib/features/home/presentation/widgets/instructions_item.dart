import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';

class InstructionsItem extends StatelessWidget {
  final String text;
  const InstructionsItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyleManager.font14Medium.copyWith(
              color: AppColors.secondaryColor,
            ),
          ),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyleManager.font14Medium.copyWith(
              color: AppColors.mainBlack,
            ),
          ),
        ],
      ),
    );
  }
}
