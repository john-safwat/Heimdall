
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

abstract class CardsRepository{

  Future<void> addLock({required String uid , required LockCard lockCard});
  Future<List<LockCard>> getCardsList({required String uid});
  Future<LockCard> getCard({required String uid , required String lockId});
  Future<void> addCardsToCache({required List<LockCard> cards});
  List<LockCard> getCardsFromCache();
  Future<void> clearCache();
}