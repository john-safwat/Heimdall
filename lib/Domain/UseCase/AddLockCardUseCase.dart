import 'package:heimdall/Data/Repository/CardsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';

AddLockCardUseCase injectAddLockCardUseCase(){
  return AddLockCardUseCase(repository: injectCardsRepository());
}

class AddLockCardUseCase {

  CardsRepository repository ;
  AddLockCardUseCase({required this.repository});

  Future<void> invoke({required String uid , required LockCard lockCard , required MyUser user})async{
    await repository.addLock(uid: uid, lockCard: lockCard);
  }

}