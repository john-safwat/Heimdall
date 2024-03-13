import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Notification/NotificationDTO.dart';

class MyNotification {
  String id;
  String body;
  List<String> urls;
  String priority;
  DateTime time;

  MyNotification(
      {required this.id,
      required this.body,
      required this.priority,
      required this.time,
      required this.urls});

  NotificationDTO toDataSource() {
    return NotificationDTO(
        id: id,
        body: body,
        priority: priority,
        time: Timestamp.fromDate(time),
        urls: urls);
  }
}
