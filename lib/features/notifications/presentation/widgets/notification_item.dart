import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/color_manager/app_colors.dart';
import '../../../../core/text_style_manager/text_style_manager.dart';
import '../../../../generated/locale_keys.g.dart';

class NotificationItem extends StatelessWidget {
  final bool isWeather;
  final bool isUnread;

  const NotificationItem({
    super.key,
    required this.isWeather,
    required this.isUnread,
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
              "assets/images/green_notification.svg",
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
                        isWeather
                            ? LocaleKeys.weatherTitle.tr()
                            : LocaleKeys.checkPlantsTitle.tr(),
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

                if (isWeather)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Alexandria – Temperature: 22°C, gentle breeze",
                        style: TextStyleManager.font10Regular,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          WeatherIcon(
                            'assets/images/thermometer-warm.svg',
                            "22°C",
                          ),
                          SizedBox(width: 14.w),
                          WeatherIcon('assets/images/humidity.svg', "55%"),
                          SizedBox(width: 14.w),
                          WeatherIcon('assets/images/uv-02.svg', "UV 4"),
                          SizedBox(width: 14.w),
                          WeatherIcon('assets/images/fast-wind.svg', "12 Km/h"),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        "Mediterranean breeze is perfect. Bring inside before afternoon heat.",
                        style: TextStyleManager.font12Medium.copyWith(
                          color: AppColors.neutralGrey500,
                        ),
                      ),
                    ],
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.dailyReminder.tr(),
                        style: TextStyleManager.font10Regular,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        "Take a moment to inspect your plants for any changes! Check for new growth, pests, or signs of stress.",
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
                      "assets/images/clock-01.svg",
                      width: 14.w,
                      height: 14.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.greyColor,
                        BlendMode.srcIn,
                      ),
                    ),

                    SizedBox(width: 3.w),
                    Text(
                      "2 hours ago",
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

  Widget WeatherIcon(String assetPath, String label) {
    return Row(
      children: [
        SvgPicture.asset(
          assetPath,
          width: 14.w,
          height: 14.h,
          colorFilter: ColorFilter.mode(AppColors.greyColor, BlendMode.srcIn),
        ),
        SizedBox(width: 3.w),
        Text(
          label,
          style: TextStyleManager.font10Regular.copyWith(
            color: AppColors.greyColor,
          ),
        ),
      ],
    );
  }
}
