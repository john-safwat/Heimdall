import 'package:heimdall/Domain/Models/Notification/Notification.dart';

abstract class NotificationsRepository {

  Future<List<Notification>> getNotificationsList({required String lockId});

}