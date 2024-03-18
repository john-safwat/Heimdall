import 'package:flutter/material.dart';
import 'package:heimdall/Data/Models/Key/KeyDTO.dart';
import 'package:intl/intl.dart';

class MyKey {
  String? keyId;
  String? lockId;
  String? userId;
  String lockName;
  String? ownerId;
  String? ownerName;
  String? ownerImage;
  bool? validOnce;
  DateTime? startDate;
  DateTime? endDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  List<String>? days;

  MyKey({
    required this.keyId,
    required this.lockId,
    required this.userId,
    required this.ownerId,
    required this.lockName,
    required this.ownerName,
    required this.ownerImage,
    required this.validOnce,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.days,
  });

  KeyDTO toDataSource() {
    return KeyDTO(
        keyId: keyId,
        lockId: lockId,
        userId: userId,
        ownerId: ownerId,
        ownerName: ownerName,
        ownerImage: ownerImage,
        validOnce: validOnce,
        startDate: startDate,
        endDate: endDate,
        lockName: lockName,
        startTime: DateFormat("jm").format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            startTime!.hour,
            startTime!.minute)),
        endTime: DateFormat("jm").format(DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
            endTime!.hour,
            endTime!.minute)),
        days: days);
  }
}
