import 'package:heimdall/Data/Repository/CardsRepositoryImpl.dart';
import 'package:heimdall/Data/Repository/NotificationsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';
import 'package:heimdall/Domain/Repository/NotificationsRepository.dart';

GetLocksCarsUseCase injectGetLocksCarsUseCase() {
  return GetLocksCarsUseCase(
      repository: injectCardsRepository(),
      notificationsRepository: injectNotificationsRepository());
}

class GetLocksCarsUseCase {
  CardsRepository repository;
  NotificationsRepository notificationsRepository;

  GetLocksCarsUseCase(
      {required this.repository, required this.notificationsRepository});

  Future<List<LockCard>> invoke({required String uid}) async {
    var response = await repository.getCardsList(uid: uid);
    var localData = await repository.getCardsFromCache();

    var unSubscribedLocks = updateSubscriptionsState(response, localData);

    if(unSubscribedLocks.isNotEmpty){
      await updateSubscriptions(unSubscribedLocks);
      await repository.clearCache();
      await repository.addCardsToCache(cards: response);
    }

    return response;
  }

  List<LockCard> updateSubscriptionsState(
      List<LockCard> response, List<LockCard> localData) {
    if (localData.isEmpty) {
      return response;
    }
    for(int i = 0 ;i<response.length ; i++){
      for (int j = 0 ; j<localData.length ; j++){
        if (response[i].lockId == localData[j].lockId){
          response[i].subscribed = true;
        }
      }
    }
    return response.where((element) => !element.subscribed).toList();
  }

  updateSubscriptions(List<LockCard> unSubscribedLocks) async{
    for(int i = 0; i<unSubscribedLocks.length ; i++){
      await notificationsRepository.subscribeToTopic(lockId: unSubscribedLocks[i].lockId);
    }
  }
}
