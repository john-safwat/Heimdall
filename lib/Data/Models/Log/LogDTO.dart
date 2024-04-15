import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Domain/Models/Log/Log.dart';

class LogDTO {
  String eventType;
  String id;

  String method;
  Timestamp timeOpened;
  String uid;
  String userName;

  LogDTO({
    required this.eventType,
    required this.id,
    required this.method,
    required this.timeOpened,
    required this.uid,
    required this.userName,
  });

  LogDTO.fromFireStore(Map<String, dynamic> json)
      : this(
          eventType: json["eventType"]??"Opening",
          id: json["id"],
          method: json["method"]??"Physical",
          timeOpened: json["timeOpened"],
          uid: json["userId"]??"Admin",
          userName: json["userName"]??"Admin",
        );

  Map<String, dynamic> toFireStore() {
    return {
      "eventType": eventType,
      "id": id,
      "method": method,
      "timeOpened": timeOpened,
      "userId": uid,
      "userName": userName,
    };
  }

  Log toDomain() {
    return Log(
        eventType: eventType,
        id: id,
        method: method,
        timeOpened: timeOpened.toDate(),
        uid: uid,
        userName: userName);
  }
}
