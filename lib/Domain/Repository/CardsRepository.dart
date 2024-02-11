
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

abstract class CardsRepository{

  Future<void> addLock({required String uid , required LockCard lockCard});
  Future<List<LockCard>> getCardsList({required String uid});
}