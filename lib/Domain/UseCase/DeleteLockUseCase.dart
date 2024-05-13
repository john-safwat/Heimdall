import 'package:heimdall/Data/Repository/CardsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/UserLockRepositoryImpl.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';
import 'package:heimdall/Domain/Repository/UserLockRepository.dart';

DeleteLockUseCase injectDeleteLockUseCase() {
  return DeleteLockUseCase(
      cardsRepository: injectCardsRepository(),
      userLockRepository: injectUserLockRepository(),
      notificationsRepository: injectNotificationsRepository()
  );
}

class DeleteLockUseCase {
  UserLockRepository userLockRepository;
  CardsRepository cardsRepository;
  NotificationsRepository notificationsRepository;

  DeleteLockUseCase(
      {required this.cardsRepository, required this.userLockRepository, required this.notificationsRepository});

  Future<void> invoke({required String uid, required String lockId}) async {
    await userLockRepository.deleteUser(uid: uid, lockId: lockId);
    await cardsRepository.deleteLock(uid: uid, lockId: lockId);
    await notificationsRepository.unsubscribeFromTopic(lockId: lockId);
  }
}
