import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

import '../../../../core/color_manager/app_colors.dart';

class MyChatBubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const MyChatBubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUser) ...[
            Container(
              width: 32.w,
              height: 32.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.gradient2, AppColors.gradient1],
                ),
              ),
              padding: EdgeInsets.all(11.w),
              child: SvgPicture.asset('assets/images/chatbot.svg'),
            ),
            SizedBox(width: 8.w),
          ],

          ChatBubble(
            clipper: ChatBubbleClipper1(
              type: isUser ? BubbleType.sendBubble : BubbleType.receiverBubble,
            ),
            backGroundColor: isUser
                ? AppColors.primaryColor
                : AppColors.secondaryColor,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.65,
              ),
              child: Text(
                message,
                style: TextStyleManager.font16Medium.copyWith(
                  color: AppColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
