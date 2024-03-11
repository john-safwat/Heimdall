
import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';

GetNotificationsListUseCase injectGetNotificationsListUseCase(){
  return GetNotificationsListUseCase(notificationsRepository: injectNotificationsRepository());
}

class GetNotificationsListUseCase {

  NotificationsRepository notificationsRepository;
  GetNotificationsListUseCase({required this.notificationsRepository});

  Future<List<Notification>> invoke({required String lockId})async {

    var response = await notificationsRepository.getNotificationsList(lockId: lockId);
    return response;

  }

}