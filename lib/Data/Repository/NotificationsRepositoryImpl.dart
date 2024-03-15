import 'package:heimdall/Data/DataSource/FirebaseLockNotificationsRemoteDataSourceImpl.dart';
import 'package:heimdall/Data/DataSource/FirebaseMessagingRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockNotificationsRemoteDataSource.dart';
import 'package:heimdall/Domain/DataSource/FirebaseMessagingRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';

NotificationsRepository injectNotificationsRepository() {
  return NotificationsRepositoryImpl(
    remoteDataSource: injectFirebaseLockNotificationsRemoteDataSource(),
    messagingRemoteDataSource: injectFirebaseMessagingRemoteDataSource()
  );
}

class NotificationsRepositoryImpl implements NotificationsRepository {
  FirebaseLockNotificationsRemoteDataSource remoteDataSource;
  FirebaseMessagingRemoteDataSource messagingRemoteDataSource;

  NotificationsRepositoryImpl(
      {required this.remoteDataSource,
      required this.messagingRemoteDataSource});

  @override
  Future<List<MyNotification>> getNotificationsList(
      {required String lockId}) async {
    var response = await remoteDataSource.getNotificationsList(lockId: lockId);
    return response;
  }

  @override
  Future<void> addNotification({required MyNotification notification}) async {
    await remoteDataSource.addNotification(
        notification: notification.toDataSource());
  }

  @override
  Future<List<MyNotification>> getAllNotificationsList() async {
    var response = await remoteDataSource.getAllNotificationsList();
    return response;
  }

  @override
  Future<void> subscribeToTopic({required String lockId})async {
    await messagingRemoteDataSource.subscribeToTopic(lockId: lockId);
  }

  @override
  Future<void> unsubscribeFromTopic({required String lockId}) async{
    await messagingRemoteDataSource.unsubscribeFromTopic(lockId: lockId);
  }
}
