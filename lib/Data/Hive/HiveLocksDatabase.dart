import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Card/HiveLockCardDTO.dart';
import 'package:hive/hive.dart';

HiveLocksDatabase injectHiveLocksDatabase(){
  return HiveLocksDatabase.getInstance();
}

class HiveLocksDatabase extends BaseDatabase{

  HiveLocksDatabase._();
  static HiveLocksDatabase? instance;
  static getInstance(){
    return instance??=HiveLocksDatabase._();
  }

  late Box<HiveLockCardDTO> box;

  initDatabase()async{
    Hive.registerAdapter(HiveLockCardDTOAdapter());
    box = await Hive.openBox<HiveLockCardDTO>(constants.locksCardsBox);
  }

  Future<void> addCards({required List<HiveLockCardDTO> cards})async{
    box = Hive.box(constants.locksCardsBox);
    await box.addAll(cards);
  }

  Future<List<HiveLockCardDTO>> getCards()async{
    box = Hive.box(constants.locksCardsBox);
    var response = box.values.cast<HiveLockCardDTO>().toList();
    return response;
  }

  Future<void> deleteCards()async{
    box = Hive.box(constants.locksCardsBox);
    await box.clear();
  }

}