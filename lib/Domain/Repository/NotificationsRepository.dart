import 'package:heimdall/Domain/Models/Notification/Notification.dart';

abstract class NotificationsRepository {

  Future<List<MyNotification>> getNotificationsList({required String lockId});
  Future<void> addNotification({required MyNotification notification});
  Future<List<MyNotification>> getAllNotificationsList();

}