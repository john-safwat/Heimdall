import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Log/LogDTO.dart';

class Log {
  String eventType;
  String id;

  String method;
  DateTime timeOpened;
  String uid;
  String userName;

  Log({
    required this.eventType,
    required this.id,
    required this.method,
    required this.timeOpened,
    required this.uid,
    required this.userName,
  });

  LogDTO toDataSource() {
    return LogDTO(
        eventType: eventType,
        id: id,
        method: method,
        timeOpened: Timestamp.fromDate(timeOpened),
        uid: uid,
        userName: userName);
  }
}
