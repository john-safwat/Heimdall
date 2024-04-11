import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:hive/hive.dart';

part 'HiveLockCardDTO.g.dart';

@HiveType(typeId: 1)
class HiveLockCardDTO extends HiveObject {
  @HiveField(0)
  String lockId;
  @HiveField(1)
  int color;
  @HiveField(2)
  String name;
  @HiveField(3)
  String image;
  @HiveField(4)
  bool subscribed;

  HiveLockCardDTO(
      {required this.image,
      required this.name,
      required this.color,
      required this.lockId,
      required this.subscribed});

  LockCard toDomain() {
    return LockCard(
      image: image,
      name: name,
      color: color,
      lockId: lockId,
    );
  }
}
