import 'package:heimdall/Data/Models/Card/HiveLockCardDTO.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

abstract class HiveLockCardsLocalDataSource {

  Future<void> addCards({required List<HiveLockCardDTO> cards});
  List<LockCard> getCards();
  Future<void> deleteCards();

}