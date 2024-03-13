import 'package:heimdall/Data/Models/Notification/NotificationDTO.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';

abstract class FirebaseLockNotificationsRemoteDataSource {

  Future<List<MyNotification>> getNotificationsList({required String lockId});
  Future<void> addNotification({required NotificationDTO notification});
  Future<List<MyNotification>> getAllNotificationsList();
}