import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Notification/NotificationDTO.dart';
import 'package:flutter/material.dart';

class MyNotification {
  String id;
  String body;
  List<String> urls;
  String priority;
  DateTime time;
  int code;
  late Color backgroundColor;
  late Color iconColor;
  late IconData icon;
  late String title;

  MyNotification(
      {required this.id,
      required this.body,
      required this.priority,
      required this.time,
      required this.urls,
      required this.code});

  NotificationDTO toDataSource() {
    return NotificationDTO(
        id: id,
        body: body,
        priority: priority,
        time: Timestamp.fromDate(time),
        urls: urls,
        code: code);
  }
}
