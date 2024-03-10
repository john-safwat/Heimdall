import 'package:heimdall/Domain/Models/Notification/Notification.dart';

abstract class FirebaseLockNotificationsRemoteDataSource {

  Future<List<Notification>> getNotificationsList({required String lockId});

}