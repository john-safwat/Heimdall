import 'package:heimdall/Data/Models/Card/LockCardDTO.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

abstract class FirebaseLockCardRemoteDataSource {

  Future<void> addLock({required String uid , required LockCardDTO lockCard});
  Future<List<LockCard>> getCardsList({required String uid});
}