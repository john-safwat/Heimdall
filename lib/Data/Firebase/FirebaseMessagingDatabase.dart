import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Core/Notifications/NotificationsManager.dart';

FirebaseMessagingDatabase injectFirebaseMessagingDatabase(){
  return FirebaseMessagingDatabase.getInstance();
}

class FirebaseMessagingDatabase extends BaseDatabase {
  static NotificationsManager notificationsManager = injectNotificationsManager();
  FirebaseMessagingDatabase._();

  static FirebaseMessagingDatabase? instance;

  static getInstance() {
    return instance ??= FirebaseMessagingDatabase._();
  }

  static Future<void> initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );


    FirebaseMessaging.onMessage.listen((RemoteMessage message) {

      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message title: ${message.notification?.title}');
      print('Message body: ${message.notification?.body}');

      if (message.notification != null) {
        notificationsManager.showNotifications(
            notificationId: message.messageId??"hiemdall", channelName: message.messageId??"hiemdall", code: message.data["code"]);
      }
    });
  }

  Future<void> subscribeToTopic({required String lockId}) async {
    await FirebaseMessaging.instance.subscribeToTopic(lockId);
  }

  Future<void> unsubscribeFromTopic({required String lockId}) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(lockId);
  }
}
