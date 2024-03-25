import 'package:heimdall/Data/DataSource/FirebaseLockCardRemoteDataSourceImpl.dart';
import 'package:heimdall/Data/DataSource/HiveLockCardsLocalDataSourceImpl.dart';
import 'package:heimdall/Data/Models/Card/HiveLockCardDTO.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockCardRemoteDataSource.dart';
import 'package:heimdall/Domain/DataSource/HiveLockCardsLocalDataSource.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';

CardsRepository injectCardsRepository() {
  return CardsRepositoryImpl(
      remoteDataSource: injectFirebaseLockCardRemoteDataSource(),
      localDataSource: injectHiveLockCardsLocalDataSource());
}

class CardsRepositoryImpl implements CardsRepository {
  FirebaseLockCardRemoteDataSource remoteDataSource;
  HiveLockCardsLocalDataSource localDataSource;

  CardsRepositoryImpl(
      {required this.remoteDataSource, required this.localDataSource});

  @override
  Future<void> addLock(
      {required String uid, required LockCard lockCard}) async {
    await remoteDataSource.addLock(
        uid: uid, lockCard: lockCard.toLockCardDTO());
  }

  @override
  Future<List<LockCard>> getCardsList({required String uid}) async {
    var response = await remoteDataSource.getCardsList(uid: uid);
    return response;
  }

  @override
  Future<LockCard> getCard(
      {required String uid, required String lockId}) async {
    var response = await remoteDataSource.getCard(uid: uid, lockId: lockId);
    return response;
  }

  @override
  Future<void> addCardsToCache({required List<LockCard> cards}) async{
    await localDataSource.addCards(cards: cards.map((e) => e.toHiveLockCardDTO()).toList());
  }

  @override
  Future<List<LockCard>> getCardsFromCache() async{
    var response = await localDataSource.getCards();
    return response;
  }

  @override
  Future<void> clearCache() async{
    await localDataSource.deleteCards();

  }
}
