
import 'package:heimdall/Domain/Models/Card/LockCard.dart';

abstract class CardsRepository{

  Future<void> addLock({required String uid , required LockCard lockCard});

}