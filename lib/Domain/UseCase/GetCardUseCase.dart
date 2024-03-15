import 'package:heimdall/Data/Repository/CardsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';

GetCardUseCase injectGetCardUseCase(){
  return GetCardUseCase(repository: injectCardsRepository());
}

class GetCardUseCase {
  CardsRepository repository;
  GetCardUseCase({required this.repository});

  Future<LockCard> invoke({required String uid, required String lockId })async {
    var response = await repository.getCard(uid: uid, lockId: lockId);
    return response;
  }

}