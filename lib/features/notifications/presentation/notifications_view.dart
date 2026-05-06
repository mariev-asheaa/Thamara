import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thamara/core/color_manager/app_colors.dart';
import 'package:thamara/features/notifications/presentation/cubit/notifications_cubit.dart';
import 'package:thamara/features/notifications/presentation/widgets/notification_item.dart';
import 'package:thamara/features/notifications/presentation/widgets/notifications_header.dart';
import '../../../core/widgets/custom_error.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            left: 16.w,
            right: 16.w,
            bottom: 40.h,
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              await context.read<NotificationsCubit>().fetchNotifications(isRefresh: true);
            },
            child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NotificationsHeader(),
                    SizedBox(height: 37.h),
                  ],
                ),

                BlocBuilder<NotificationsCubit, NotificationsState>(
                  builder: (context, state) {
                    if (state is NotificationsSuccess) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.notifications.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: NotificationItem(
                              notificationModel: state.notifications[index],
                              isUnread: index < 2,
                            ),
                          );
                        },
                      );
                    }

                   else if (state is NotificationsFailure) {
                      return CustomError(
                        error: state.error,
                        retry: () {
                          context.read<NotificationsCubit>().fetchNotifications();
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    );
                  },
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
