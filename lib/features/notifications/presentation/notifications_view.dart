import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/notifications/presentation/widgets/notification_item.dart';
import 'package:thamara/features/notifications/presentation/widgets/notifications_header.dart';
import 'package:thamara/features/notifications/presentation/widgets/notifications_tab_filter.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  bool isAllSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 40.h,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NotificationsHeader(),

                SizedBox(height: 26.h),
                NotificationTabFilter(
                  isAllSelected: isAllSelected,
                  onTabChanged: (value) {
                    setState(() {
                      isAllSelected = value;
                    });
                  },
                ),
                SizedBox(height: 37.h),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: NotificationItem(
                        isWeather: index % 2 == 0,
                        isUnread: index < 2,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
