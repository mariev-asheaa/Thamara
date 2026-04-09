import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:thamara/core/text_style_manager/text_style_manager.dart';

import '../../generated/locale_keys.g.dart';
import '../color_manager/app_colors.dart';

class CustomNavBar extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;
  const CustomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 64.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(500.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.gradient2, AppColors.gradient1],
                ),
              ),

              child: FittedBox(
               child : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: GNav(
                    selectedIndex: widget.selectedIndex,
                    onTabChange: (index) {
                      widget.onTabChange(index);
                    },

                    gap: 4.w,
                    tabBackgroundColor: AppColors.whiteColor,

                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 6.h,
                    ),
                    tabs: [
                      buildGButton(
                        index: 0,
                        iconPath: 'assets/images/home.svg',
                        label: LocaleKeys.navHome.tr(),
                      ),
                      buildGButton(
                        index: 1,
                        iconPath: 'assets/images/plants.svg',
                        label: LocaleKeys.navTracking.tr(),
                      ),
                      buildGButton(
                        index: 2,
                        iconPath: 'assets/images/notifications.svg',
                        label: LocaleKeys.navPlants.tr(),
                      ),
                      buildGButton(
                        index: 3,
                        iconPath: 'assets/images/setting.svg',
                        label: LocaleKeys.navProfile.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Container(
            height: 64.h,
            width: 64.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.gradient2, AppColors.gradient1],
              ),
            ),
            child: GestureDetector(
              onTap: () {},
              child: Center(
                child: SvgPicture.asset('assets/images/chatbot.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GButton buildGButton({
    required int index,
    required String iconPath,
    required String label,
  }) {
    bool isSelected = widget.selectedIndex == index;

    return GButton(
      icon: Icons.home,
      text: label,
      textStyle: TextStyleManager.font12Bold.copyWith(
        color: AppColors.darkPrimary2,
      ),
      leading: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.secondaryColor2 : Colors.transparent,
        ),
        child: SvgPicture.asset(iconPath),
      ),
    );
  }
}
