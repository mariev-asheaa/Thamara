import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/core/constants/app_assets.dart';

import '../../../../core/text_style_manager/text_style_manager.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputField({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 16.h,
        left: 16.w,
        right: 16.w,
        bottom: 32.h,
      ),
      color: AppColors.whiteColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write your message...",
                hintStyle: TextStyleManager.font16Regular.copyWith(
                  color: AppColors.greyColor,
                ),
                fillColor: AppColors.backgroundColor,
                filled: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 26.w,
                  vertical: 10.h,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(500.r),
                  borderSide: BorderSide(
                    color: AppColors.blackColor.withValues(alpha: .25),
                    width: 1.1,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(500.r),
                  borderSide: BorderSide(
                    color: AppColors.blackColor.withValues(alpha: .25),
                    width: 1.1,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 16.w),

          GestureDetector(
            onTap: onSend,
            child: Container(
              height: 44.h,
              width: 44.w,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  AppAssets.sendMessageButton,
                  width: 22.w,
                  height: 22.h,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
