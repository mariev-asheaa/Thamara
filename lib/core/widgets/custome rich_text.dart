import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../color_manager/app_colors.dart';
import '../text_style_manager/text_style_manager.dart';

class CustomRichText extends StatelessWidget {
  final String text;
  final String actionText;
  final VoidCallback onTap;

  const CustomRichText({
    super.key,
    required this.text,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: TextStyleManager.font14Medium
          ),
          TextSpan(
            text: actionText,
            style: TextStyleManager.font14Bold.copyWith(color: AppColors.secondaryColor),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}