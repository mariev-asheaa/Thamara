import 'dart:io';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../../app/thamara_app.dart';
import '../dependency_injection/di.dart';
import 'fcm_navigation_service.dart';

class NotificationService {
  NotificationService() {
    _initNotifications();
  }

  static const String _prefsMsgIndexKey = 'notif_msg_index';
  static const String _channelId = 'exploitus_weekly_channel';
  static const String _channelName = 'ExploitUs Weekly Reminders';

  final List<Map<String,String>> weeklyMessages= [
      {
        "title": "Have you checked on your plants today?",
        "body": "Take a moment to inspect your plants for any changes!Check for new growth, pests, or signs of stress. Early detection prevents problems!"
      },
  ];


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
    tz.initializeTimeZones();

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
      _channelId,
      _channelName,
      importance: Importance.max,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
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

  Future<void> schedulePermanentNotifications({
    int dayInterval = 5,
    int hour = 9,
    int minute = 0,
    int batchSize = 20,
  }) async {
    try {
      final prefs = await _getPrefs();
      int msgIndex = prefs.getInt(_prefsMsgIndexKey) ?? 0;

      const lastScheduleDateKey = 'last_schedule_date';
      final now = DateTime.now();
      final lastScheduleDate = prefs.getString(lastScheduleDateKey);
      bool shouldReschedule = false;

      if (lastScheduleDate == null) {
        shouldReschedule = true;
      } else {
        final lastDate = DateTime.parse(lastScheduleDate);
        final daysSinceLastSchedule = now.difference(lastDate).inDays;
        final halfBatchDuration = (batchSize * dayInterval) ~/ 2;
        if (daysSinceLastSchedule >= halfBatchDuration) {
          shouldReschedule = true;
        } else {
          return;
        }
      }

      if (!shouldReschedule) return;

      await _cancelPreviousPermanentNotifications(batchSize);

      const platformDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          _channelName,
          importance: Importance.high,
          priority: Priority.high,
          enableVibration: true,
          playSound: true,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      final currentTime = tz.TZDateTime.now(tz.local);
      final firstNotificationTime = tz.TZDateTime(
        tz.local,
        currentTime.year,
        currentTime.month,
        currentTime.day + dayInterval,
        hour,
        minute,
      );

      final adjustedFirstTime =
          firstNotificationTime.isBefore(
            currentTime.add(const Duration(hours: 1)),
          )
          ? firstNotificationTime.add(const Duration(days: 1))
          : firstNotificationTime;

      for (int i = 0; i < batchSize; i++) {
        final scheduledDate = adjustedFirstTime.add(
          Duration(days: dayInterval * i),
        );
        final notificationId = 2000 + i;
        final message = weeklyMessages[(msgIndex + i) % weeklyMessages.length];

        await flutterLocalNotificationsPlugin.zonedSchedule(
          id: notificationId,
          scheduledDate: scheduledDate,
          notificationDetails: platformDetails,
          title: message['title'],
          body: message['body'],
          payload: 'permanent_reminder_$i',
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        );
      }

      await prefs.setString(lastScheduleDateKey, now.toIso8601String());
      await prefs.setInt(
        _prefsMsgIndexKey,
        (msgIndex + batchSize) % weeklyMessages.length,
      );
    } catch (e, stackTrace) {
      debugPrint('schedulePermanentNotifications error: $e\n$stackTrace');
      rethrow;
    }
  }

  Future<void> _cancelPreviousPermanentNotifications(int batchSize) async {
    for (int i = 0; i < batchSize; i++) {
      await flutterLocalNotificationsPlugin.cancel(id: 2000 + i);
    }
  }

  Future<SharedPreferences> _getPrefs() async {
    try {
      return getIt<SharedPreferences>();
    } catch (_) {
      return await SharedPreferences.getInstance();
    }
  }
}
