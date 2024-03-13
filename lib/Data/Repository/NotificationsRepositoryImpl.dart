import 'package:heimdall/Data/DataSource/FirebaseLockNotificationsRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockNotificationsRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';

NotificationsRepository injectNotificationsRepository(){
  return NotificationsRepositoryImpl(remoteDataSource: injectFirebaseLockNotificationsRemoteDataSource());
}

class NotificationsRepositoryImpl implements NotificationsRepository{

  FirebaseLockNotificationsRemoteDataSource remoteDataSource;
  NotificationsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MyNotification>> getNotificationsList({required String lockId}) async{
    var response = await remoteDataSource.getNotificationsList(lockId: lockId);
    return response;
  }

  @override
  Future<void> addNotification({required MyNotification notification}) async{
    await remoteDataSource.addNotification(notification: notification.toDataSource());
  }

  @override
  Future<List<MyNotification>> getAllNotificationsList() async {
    var response = await remoteDataSource.getAllNotificationsList();
    return response;
  }

}