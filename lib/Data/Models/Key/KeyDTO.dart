import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:intl/intl.dart';

class KeyDTO {

  String? keyId;
  String? lockId;
  String? userId;
  String? ownerId;
  String? ownerName;
  String? ownerImage;
  bool? validOnce;
  DateTime? startDate;
  DateTime? endDate;
  String? startTime;
  String? lockName;
  String? endTime;
  List<String>? days;

  KeyDTO({
    required this.keyId,
    required this.lockId,
    required this.userId,
    required this.lockName,
    required this.ownerId,
    required this.ownerName,
    required this.ownerImage,
    required this.validOnce,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.days,
  });

  KeyDTO.fromFireStore(Map<String, dynamic> json){
    keyId = json["keyId"];
    lockId = json["lockId"];
    userId = json["userId"];
    ownerId = json["ownerId"];
    ownerName = json["ownerName"];
    lockName = json["lockName"];
    ownerImage = json["ownerImage"];
    validOnce = json["validOnce"];
    startDate = (json["startDate"] as Timestamp).toDate();
    endDate =  (json["endDate"] as Timestamp).toDate();
    startTime = json["startTime"];
    endTime = json["endTime"];
    if (json["days"] != null) {
      List<dynamic> data = [];
      data.addAll(json["days"]! as List<dynamic>);
      days = data.map((e) => e.toString()).toList();
    }
  }

  Map<String, dynamic> toFireStore() {
    return {
      "keyId": keyId,
      "lockId": lockId,
      "userId": userId,
      "ownerId": ownerId,
      "ownerName": ownerName,
      "ownerImage": ownerImage,
      "validOnce": validOnce,
      "startDate": startDate,
      "endDate": endDate,
      "startTime": startTime,
      "endTime": endTime,
      "days": days,
      "lockName" : lockName
    };
  }

  EKey toDomain() {
    return EKey(keyId: keyId,
        lockId: lockId,
        userId: userId,
        ownerId: ownerId,
        ownerName: ownerName,
        ownerImage: ownerImage,
        validOnce: validOnce,
        startDate: startDate,
        endDate: endDate,
        lockName: lockName!,
        startTime: TimeOfDay.fromDateTime(DateFormat.jm().parse(startTime!)),
        endTime: TimeOfDay.fromDateTime(DateFormat.jm().parse(endTime!)),
        days: days);
  }

}