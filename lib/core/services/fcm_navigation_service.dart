import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thamara/app/thamara_app.dart';

import '../../features/notifications/data/models/notification_model.dart';
import '../../features/notifications/data/repository/notifications_repository.dart';
import '../../features/notifications/presentation/notifications_view.dart';
import '../dependency_injection/di.dart';
import '../framework/navigation_animation.dart';

class FcmNavigationService {
  final NotificationsRepository repository;

  FcmNavigationService({required this.repository});

  static Future<void> handleNotificationNavigation(
      RemoteMessage message,) async {
    final data = message.data;
    if (data.isEmpty) {
      return;
    }

    final notificationData = NotificationModel.fromJson(data);
    final context = Thamara.appNavigatorKey.currentContext;
    if (context?.mounted ?? false) {
      await _markNotificationAsRead(context!, notificationData);
    }
  }

  static Future<void> _markNotificationAsRead(BuildContext context,
      NotificationModel data,) async {
    final repository = getIt<NotificationsRepository>();
    final result = await repository.markAsReadBasedOnId(
      notificationId: data.id.toString(),
    );
    result.fold((failure) {}, (_) async {
      await Navigator.push(context,
          FadePageRoute(builder: (context) => NotificationsView())
      );
    });
  }
}