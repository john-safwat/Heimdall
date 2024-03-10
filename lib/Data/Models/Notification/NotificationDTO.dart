import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Domain/Models/Notification/Notification.dart';

class NotificationDTO {
  String? id;
  String? body;
  List<String>? urls;
  String? priority;
  Timestamp?time;

  NotificationDTO(
      {required this.id,
      required this.body,
      required this.priority,
      required this.time,
      required this.urls});

  NotificationDTO.fromFireStore(dynamic json){
    id = json["id"];
    body = json["body"];
    priority = json["priority"];
    time = json["time"];
    if(json["images_url"] != null){
      List<dynamic> data = [];
      data.addAll(json["images_url"]! as List<dynamic>);
      urls = data.map((e) => e.toString()).toList();
    }
  }

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "body": body,
      "images_url": urls,
      "priority": priority,
      "time": time,
    };
  }

  Notification toDomain() {
    return Notification(
        id: id!, body: body!, priority: priority!, time: time!.toDate(), urls: urls??[]);
  }
}
