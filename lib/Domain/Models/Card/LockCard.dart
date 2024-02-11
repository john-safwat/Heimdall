import 'package:heimdall/Data/Models/Card/LockCardDTO.dart';

class LockCard {
  String lockId;
  int color;
  String name;
  String image;

  LockCard(
      {required this.image,
      required this.name,
      required this.color,
      required this.lockId,});

  LockCardDTO toDataSource() {
    return LockCardDTO(
        image: image,
        name: name,
        color: color,
        lockId: lockId,);
  }
}
