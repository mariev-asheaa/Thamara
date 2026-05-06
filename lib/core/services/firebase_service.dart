import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

import 'notification_service.dart';
import 'fcm_navigation_service.dart';

@injectable
class FirebaseService {
  late NotificationService notificationService;

  static Future<FirebaseService> initializeFireBaseNotifications() async {
    var init = FirebaseService();
    init.notificationService = NotificationService();

    try {
      await init.registerFCMForegroundListener();
      await init.registerFCMBackgroundListener();
      await init.listenOnMessageOpenedApp();
      return init;
    } catch (e) {
      debugPrint('Firebase notifications initialization error: $e');
      rethrow;
    }
  }

  Future<void> listenOnMessageOpenedApp() async {
    try {
      FirebaseMessaging.onMessageOpenedApp.listen(
        _firebaseMessageOpenAppHandler,
      );
    } catch (e) {
      debugPrint('Message opened app listener error: $e');
    }
  }

  Future<bool> requestFCMPermission() async {
    final messaging = FirebaseMessaging.instance;
    try {
      if (Platform.isIOS) {
        await messaging.setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
      }

      final settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );

      return settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getFirebaseToken() async {
    final messaging = FirebaseMessaging.instance;

    try {
      final isGranted = await requestFCMPermission();
      if (!isGranted) {
        return null;
      }

      if (Platform.isIOS) {
        await messaging.getAPNSToken();
      }

      final token = await messaging.getToken();

      return token;
    } catch (e) {
      return null;
    }
  }

  Future<void> registerFCMBackgroundListener() async {
    try {
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );
    } catch (e) {
      debugPrint('FCM background listener error: $e');
    }
  }

  Future<void> registerFCMForegroundListener() async {
    try {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        notificationService.showNotification(message);
      });
    } catch (e) {
      debugPrint('FCM foreground listener error: $e');
    }
  }

  Future<void> handleTerminatedNotification() async {
    try {
      final initialMessage = await FirebaseMessaging.instance
          .getInitialMessage();
      if (initialMessage != null) {
        await _firebaseMessageOpenAppHandler(initialMessage);
      }
    } catch (e) {
      debugPrint('Handle terminated notification error: $e');
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('Background message: ${message.messageId}');
}
@pragma('vm:entry-point')
Future<void> _firebaseMessageOpenAppHandler(RemoteMessage message) async {
  await FcmNavigationService.handleNotificationNavigation(message);
}