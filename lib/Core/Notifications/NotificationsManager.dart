import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:heimdall/Core/Notifications/NotificationMessageHandler.dart';
import 'package:heimdall/Core/Providers/LocalProvider.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';

NotificationsManager injectNotificationsManager() {
  return NotificationsManager.getInstance(
      messageHandler: injectNotificationMessageHandler(),
      localProvider: LocalProvider.getInstance());
}

class NotificationsManager {
  NotificationMessageHandler messageHandler;
  LocalProvider localProvider;

  NotificationsManager._(
      {required this.messageHandler, required this.localProvider});

  static NotificationsManager? instance;

  static NotificationsManager getInstance(
      {required NotificationMessageHandler messageHandler,
        required LocalProvider localProvider}) {
    return instance ??= NotificationsManager._(
        messageHandler: messageHandler, localProvider: localProvider);
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initMessaging() async {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('ic_notifications');

    const InitializationSettings initializationSettings =
    InitializationSettings(android: initializationSettingsAndroid);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  Future<void> showNotifications(
      {required String notificationId,
        required String channelName,
        required String code, required String local}) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(notificationId, channelName,
        channelDescription: "This Notification for Lock Action",
        importance: Importance.max,
        icon: "ic_notifications",
        channelShowBadge: true,
        color: const Color(0xFF29384D),
        colorized: true,
        enableVibration: true,
        playSound: true,
        priority: Priority.high,
        ticker: local == "en"
            ? messageHandler.handleNotificationTitleEnglish(code)
            : messageHandler.handleNotificationTitleArabic(code));
    NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    int id = DateTime.now().millisecondsSinceEpoch~/1000;
    await flutterLocalNotificationsPlugin.show(
        id,
        local == "en"
            ? messageHandler.handleNotificationTitleEnglish(code)
            : messageHandler.handleNotificationTitleArabic(code),
        local == "en"
            ? messageHandler.handleNotificationBodyEnglish(code)
            : messageHandler.handleNotificationBodyArabic(code),
        notificationDetails);
  }
}