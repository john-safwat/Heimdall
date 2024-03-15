
import 'package:flutter/material.dart';
import 'package:heimdall/Core/Theme/MyTheme.dart';
import 'package:heimdall/Data/Repository/CardsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';
import 'package:icons_plus/icons_plus.dart';

GetNotificationsListUseCase injectGetNotificationsListUseCase(){
  return GetNotificationsListUseCase(
    notificationsRepository: injectNotificationsRepository(),
    repository: injectCardsRepository()
  );
}

class GetNotificationsListUseCase {

  NotificationsRepository notificationsRepository;
  CardsRepository repository;
  GetNotificationsListUseCase({required this.notificationsRepository ,required this.repository});

  Future<List<MyNotification>> invoke({required String uid})async {

    var response = await notificationsRepository.getAllNotificationsList();
    var cards = await repository.getCardsList(uid: uid);

    List<MyNotification> notifications = [];

    for(int i =0 ; i<cards.length;i++){
      notifications.addAll(response.where((element) => element.id == cards[i].lockId).toList());
    }

    return sortNotificationsByTime(notifications);

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