import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';

// Function for dependency injection of the GetLockImagesListUseCase
GetLockImagesListUseCase injectGetLockImagesListUseCase() {
  return GetLockImagesListUseCase(repository: injectNotificationsRepository());
}

class GetLockImagesListUseCase {
  // Repository for accessing notification data
  NotificationsRepository repository;

  // Constructor, injecting the repository dependency
  GetLockImagesListUseCase({required this.repository});

  // Core method to retrieve a list of image URLs for a given lock
  Future<List<String>> invoke({required String lockId}) async {
    // Fetch notifications for the specified lock ID
    var response = await repository.getNotificationsList(lockId: lockId);

    // Sort notifications by time in descending order
    var sortedNotifications = sortNotificationsByTime(response);

    // Extract image URLs from sorted notifications
    return getNotificationsImagesList(sortedNotifications);
  }

  // Helper function to sort notifications by time
  List<MyNotification> sortNotificationsByTime(List<MyNotification> notifications) {
    // Create a copy to avoid modifying the original list
    List<MyNotification> sortedNotifications = List.from(notifications);

    // Sort using the 'time' property of Notification objects
    sortedNotifications.sort((a, b) => a.time.compareTo(b.time));

    return sortedNotifications;
  }

  // Helper function to extract image URLs from notifications
  List<String> getNotificationsImagesList(List<MyNotification> notifications) {
    List<String> images = [];

    // Iterate through notifications in reverse order
    for (int i = 0; i < notifications.length; i++) {
      // Add image URLs from the current notification, if any
      if (notifications[i].urls.isNotEmpty) {
        images.addAll(notifications[i].urls); // More efficient than nested loop
      }
    }

    return images;
  }
}
