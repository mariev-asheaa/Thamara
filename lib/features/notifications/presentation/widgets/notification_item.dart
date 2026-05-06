import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thamara/core/constants/app_assets.dart';
import 'package:thamara/features/notifications/data/models/notification_model.dart';
import 'package:thamara/features/notifications/presentation/widgets/weather_icon.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';

class NotificationItem extends StatelessWidget {
  final bool isUnread;
final NotificationModel notificationModel;
  const NotificationItem({
    super.key,
    required this.isUnread,
    required this.notificationModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 26.w),
      decoration: BoxDecoration(
        color: AppColors.whiteColor2,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primaryColor.withValues(alpha: .25),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColors.primaryColor),
            ),
            child: SvgPicture.asset(
             AppAssets.notificationIcon,
              width: 22.w,
              height: 22.h,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        notificationModel.title,
                        style: TextStyleManager.font16SemiBold,
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: AppColors.criticalColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),

                SizedBox(height: 4.h),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          WeatherIcon(assetPath: 'assets/images/thermometer-warm.svg', label: "22°C",),
                          SizedBox(width: 14.w),
                          WeatherIcon(assetPath: 'assets/images/humidity.svg',label:  "55%"),
                          SizedBox(width: 14.w),
                          WeatherIcon(assetPath: 'assets/images/fast-wind.svg',label:  "12 Km/h"),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                       notificationModel.body,
                        style: TextStyleManager.font12Medium.copyWith(
                          color: AppColors.neutralGrey500,
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    SvgPicture.asset(
                     AppAssets.clock,
                      width: 14.w,
                      height: 14.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.greyColor,
                        BlendMode.srcIn,
                      ),
                    ),

                    SizedBox(width: 3.w),
                    Text(
                     notificationModel.date,
                      style: TextStyleManager.font10Regular.copyWith(
                        color: AppColors.greyColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
