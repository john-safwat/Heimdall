
import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';

GetNotificationsListUseCase injectGetNotificationsListUseCase(){
  return GetNotificationsListUseCase(notificationsRepository: injectNotificationsRepository());
}

class GetNotificationsListUseCase {

  NotificationsRepository notificationsRepository;
  GetNotificationsListUseCase({required this.notificationsRepository});

  Future<List<MyNotification>> invoke({required String lockId})async {

    var response = await notificationsRepository.getAllNotificationsList();
    response = response.where((element) => element.id == lockId).toList();

    return sortNotificationsByTime(response);

  }

  // Helper function to sort notifications by time
  List<MyNotification> sortNotificationsByTime(List<MyNotification> notifications) {
    // Create a copy to avoid modifying the original list
    List<MyNotification> sortedNotifications = List.from(notifications);

    // Sort using the 'time' property of Notification objects
    sortedNotifications.sort((a, b) => a.time.compareTo(b.time));

    return sortedNotifications.reversed.toList();
  }

}