import 'package:heimdall/Data/Repository/CardsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/UserRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';
import 'package:heimdall/Domain/Repository/UserRepository.dart';

SignOutUserUseCase injectSignOutUserUseCase(){
  return SignOutUserUseCase(
      repository: injectUserRepository(),
    cardsRepository:  injectCardsRepository(),
    notificationsRepository: injectNotificationsRepository()
  );
}

class SignOutUserUseCase {

  UserRepository repository;
  CardsRepository cardsRepository;
  NotificationsRepository notificationsRepository;

  SignOutUserUseCase({required this.repository , required this.cardsRepository , required this.notificationsRepository});

  Future<void> invoke()async{

    var response = await cardsRepository.getCardsFromCache();
    await unSubscriepeFromLocks(response);
    await cardsRepository.clearCache();
    await repository.signOut();
  }

  Future<void> unSubscriepeFromLocks(List<LockCard> response) async{
    for (int i = 0; i<response.length ; i++){
      await notificationsRepository.unsubscribeFromTopic(lockId: response[i].lockId);
    }
  }

}