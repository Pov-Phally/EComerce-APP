import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../LocalNotificationService/local_notification_service.dart';

// Top-level function for background message handling
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    LocalNotificationService.showNotification(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: message.notification!.title ?? 'New Notification',
      body: message.notification!.body ?? 'You have a new order.',
    );
  }
}

class NotificationService {
  static Future<void> initializeFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Token
    String? token = await messaging.getToken();
    if (kDebugMode) {
      print('FCM Token: $token');
    }

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Request notification permissions
    await FirebaseMessaging.instance.requestPermission();

    // Subscribe to the 'orders' topic
    FirebaseMessaging.instance.subscribeToTopic('orders').then((_) {
      if (kDebugMode) {
        print('Subscribed to orders topic');
      }
    });

    // Handle foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        LocalNotificationService.showNotification(
          id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          title: message.notification!.title ?? 'New Notification',
          body: message.notification!.body ?? 'You have a new order.',
        );
      }
    });

    // Assign the top-level background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
}