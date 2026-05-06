import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../app/thamara_app.dart';
import 'fcm_navigation_service.dart';

class NotificationService {
  NotificationService() {
    _initNotifications();
  }
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final DarwinInitializationSettings initializationSettingsIOS =
      const DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

  static const AndroidInitializationSettings initializationSettingsAndroid =
          AndroidInitializationSettings('@mipmap/ic_launcher');

  void _initNotifications() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

    flutterLocalNotificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        debugPrint('Notification tapped: ${details.payload}');
        _handleLocalNotificationTap(details);
      },
      onDidReceiveBackgroundNotificationResponse: _onReceiveBackgroundResponse,
    );

    if (Thamara.appNavigatorKey.currentContext != null) {
      if (Platform.isAndroid) {
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission();
      } else {
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      }
    }
  }

  @pragma('vm:entry-point')
  static void _onReceiveBackgroundResponse(NotificationResponse details) async {
    debugPrint('Background notification response: ${details.payload}');
    _handleLocalNotificationTap(details);
  }

  /// Handle local notification tap (foreground or background)
  static void _handleLocalNotificationTap(NotificationResponse details) {
    try {
      final payload = details.payload;
      if (payload == null || payload.isEmpty) {
        debugPrint('Local notification: No payload');
        return;
      }

      // Check if it's a permanent reminder (scheduled notification)
      if (payload.startsWith('permanent_reminder_')) {
        debugPrint('Local notification: Permanent reminder tapped');
        // These are just reminders to open the app, no specific navigation needed
        return;
      }

      // Parse FCM data from payload
      try {
        final data = json.decode(payload) as Map<String, dynamic>;

        // Create a RemoteMessage from the payload
        final message = RemoteMessage(
          data: data,
          messageId: DateTime.now().millisecondsSinceEpoch.toString(),
        );

        // Use FCM navigation service
        FcmNavigationService.handleNotificationNavigation(message);
      } catch (e) {
        debugPrint('Local notification: Failed to parse payload: $e');
      }
    } catch (e) {
      debugPrint('Local notification handler error: $e');
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    final title =
        message.notification?.title ??
        message.data['title']?.toString() ??
        'Thamara';
    final body =
        message.notification?.body ?? message.data['body']?.toString() ?? '';

    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'Thamara Warnings',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    final id = DateTime.now().millisecondsSinceEpoch.remainder(100000);

    try {
      await flutterLocalNotificationsPlugin.show(
        id:id,
        title: title,
        body:body,
        notificationDetails:platformDetails,
        payload: message.data.isNotEmpty ? jsonEncode(message.data) : null,
      );
    } catch (e, st) {
      debugPrint('showNotification error: $e\n$st');
    }
  }
}
