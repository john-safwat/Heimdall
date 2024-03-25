import 'package:flutter/material.dart';
import 'package:heimdall/Core/Extension/DateOnlyExtinsion.dart';
import 'package:heimdall/Data/Repository/KeysRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';
import 'package:intl/intl.dart';

GetLockKeysUseCase injectGetLockKeysUseCase() {
  return GetLockKeysUseCase(repository: injectKeysRepository());
}

class GetLockKeysUseCase {
  KeysRepository repository;

  GetLockKeysUseCase({required this.repository});

  Future<List<EKey>> invoke({required String lockId}) async {
    var response = await repository.getLockKeys(lockId: lockId);
    return validate(response);
  }

  List<EKey> validate(List<EKey> keys) {
    DateTime date = DateTime.now().dateOnly(DateTime.now());
    TimeOfDay time = TimeOfDay.now();
    for (int i = 0; i < keys.length; i++) {
      keys[i].startDate = keys[i].startDate!.dateOnly(keys[i].startDate!);
      keys[i].endDate = keys[i].endDate!.dateOnly(keys[i].endDate!);

      if (date.compareTo(keys[i].startDate!) < 0) {
        keys[i].valid = true;
      } else if (date.compareTo(keys[i].endDate!) > 0) {
        keys[i].valid = true;
      } else if (time.hour < keys[i].startTime!.hour ||
          (time.hour == keys[i].startTime!.hour &&
                  time.minute < keys[i].startTime!.minute) &&
              time.period == keys[i].startTime!.period) {
        keys[i].valid = true;
      } else if (time.hour > keys[i].endTime!.hour ||
          (time.hour == keys[i].endTime!.hour &&
                  time.minute > keys[i].endTime!.minute) &&
              time.period == keys[i].endTime!.period) {
        keys[i].valid = true;
      } else {
        keys[i].valid = false;
      }
    }
    return keys;
  }
}
