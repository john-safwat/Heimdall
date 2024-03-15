import 'package:heimdall/Data/Repository/CardsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/LockRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/UserLockRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Models/Users/User.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';
import 'package:heimdall/Domain/Repository/UserLockRepository.dart';

AddLockCardUseCase injectAddLockCardUseCase() {
  return AddLockCardUseCase(
      cardsRepository: injectCardsRepository(),
      lockRepository: injectLockRepository(),
      userLockRepository: injectUserLockRepository(),
      notificationsRepository: injectNotificationsRepository()
  );
}

class AddLockCardUseCase {
  CardsRepository cardsRepository;
  LockRepository lockRepository;
  UserLockRepository userLockRepository;
  NotificationsRepository notificationsRepository;

  AddLockCardUseCase(
      {required this.cardsRepository,
      required this.lockRepository,
      required this.userLockRepository,
      required this.notificationsRepository});

  Future<void> invoke(
      {required String uid,
      required LockCard lockCard,
      required MyUser user}) async {

    var response = await lockRepository.getLockData(lockId: lockCard.lockId);
    if(response.firstOwner.isEmpty){
      response.firstOwner = user.uid;
      await lockRepository.updateLock(lock: response);
    }
    await cardsRepository.addLock(uid: uid, lockCard: lockCard);
    await userLockRepository.addLockUser(lockId: lockCard.lockId, user: user);
    await notificationsRepository.subscribeToTopic(lockId: lockCard.lockId);
  }
}
