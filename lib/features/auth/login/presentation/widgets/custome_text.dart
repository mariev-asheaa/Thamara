import 'package:flutter/material.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

class CustomText extends StatelessWidget {
  final String text;
  final bool isColored;

  const CustomText({
    super.key,
    required this.text,
    this.isColored = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyleManager.font14Bold.copyWith(
        color: isColored ? AppColors.primaryColor : AppColors.mainBlack,
      ),
    );
  }
}
