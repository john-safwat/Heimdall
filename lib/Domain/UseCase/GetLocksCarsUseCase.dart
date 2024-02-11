import 'package:heimdall/Data/Repository/CardsRepositoryImpl.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';

GetLocksCarsUseCase injectGetLocksCarsUseCase() {
  return GetLocksCarsUseCase(repository: injectCardsRepository());
}

class GetLocksCarsUseCase {
  CardsRepository repository;

  GetLocksCarsUseCase({required this.repository});

  Future<List<LockCard>> invoke({required String uid}) async {
    var response = await repository.getCardsList(uid: uid);
    return response;
  }
}
