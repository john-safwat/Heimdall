import 'package:heimdall/Domain/Models/Card/LockCard.dart';

class LockCardDTO {
  String cardId;
  String lockId;
  int color;
  String name;
  String image;

  LockCardDTO(
      {required this.image,
      required this.name,
      required this.color,
      required this.lockId,
      required this.cardId,});

  LockCardDTO.fromFireStore(Map<String, dynamic> json)
      : this(
            cardId: json["cardId"],
            lockId: json["lockId"],
            image: json["image"],
            color: json["color"],
            name: json["name"]);

  Map<String, dynamic> toFireStore() {
    return {
      "cardId": cardId,
      "lockId": lockId,
      "image": image,
      "color": color,
      "name": name,
    };
  }

  LockCard toDomain() {
    return LockCard(
        image: image,
        name: name,
        color: color,
        lockId: lockId,
        cardId: cardId,
    );
  }
}
