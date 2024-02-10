import 'package:heimdall/Data/Models/Card/LockCardDTO.dart';

class LockCard {
  String cardId;
  String lockId;
  int color;
  String name;
  String image;

  LockCard(
      {required this.image,
      required this.name,
      required this.color,
      required this.lockId,
      required this.cardId,});

  LockCardDTO toDataSource() {
    return LockCardDTO(
        image: image,
        name: name,
        color: color,
        lockId: lockId,
        cardId: cardId);
  }
}
