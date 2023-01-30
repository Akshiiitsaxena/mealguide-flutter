import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final notificationProvider = Provider(
  (ref) => NotificationHandler(ref, FlutterLocalNotificationsPlugin()),
);

class NotificationHandler {
  final ProviderRef ref;
  final FlutterLocalNotificationsPlugin notifications;

  NotificationHandler(this.ref, this.notifications);

  void initHandler() async {
    // TODO: Change later after setting app icon
    const AndroidInitializationSettings settings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: settings);

    await notifications.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onNotification);

    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  void onNotification(NotificationResponse notification) {
    final String? payload = notification.payload;
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
    // TODO: Maybe use this for adding things to shopping list prompts
  }

  void scheduleNotification(
    DateTime timestamp,
    NotificationType notificationType,
  ) async {
    await cancelNotifications(notificationType);
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('default', 'meal-notifications',
            channelDescription: 'meal-notifications');

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    int id = getIdFromNotificationType(notificationType);

    await notifications.zonedSchedule(
      id,
      'It\'s ${notificationType.toString()} time!',
      'Start prepping your meal to eat at time.',
      tz.TZDateTime.from(timestamp, tz.local),
      notificationDetails,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelNotifications(NotificationType notificationType) async {
    int id = getIdFromNotificationType(notificationType);

    if (id > 0) {
      await notifications.cancel(id);
    }
  }

  int getIdFromNotificationType(NotificationType notificationType) {
    switch (notificationType) {
      case NotificationType.breakfast:
        return 0;
      case NotificationType.lunch:
        return 1;
      case NotificationType.snacks:
        return 2;
      case NotificationType.dinner:
        return 3;
      default:
        return -1;
    }
  }
}

enum NotificationType {
  breakfast,
  lunch,
  snacks,
  dinner;

  @override
  String toString() => name;
}
