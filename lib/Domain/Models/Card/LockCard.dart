import 'package:heimdall/Data/Models/Card/HiveLockCardDTO.dart';
import 'package:heimdall/Data/Models/Card/LockCardDTO.dart';

class LockCard {
  String lockId;
  int color;
  String name;
  String image;
  bool subscribed;

  LockCard(
      {required this.image,
      required this.name,
      required this.color,
      required this.lockId,
      this.subscribed = false});

  LockCardDTO toLockCardDTO() {
    return LockCardDTO(
      image: image,
      name: name,
      color: color,
      lockId: lockId,
    );
  }

  HiveLockCardDTO toHiveLockCardDTO() {
    return HiveLockCardDTO(
      image: image,
      name: name,
      color: color,
      lockId: lockId,
      subscribed: true,
    );
  }
}
