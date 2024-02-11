import 'package:heimdall/Data/DataSource/FirebaseLockCardRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockCardRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Card/LockCard.dart';
import 'package:heimdall/Domain/Repository/CardsRepository.dart';


CardsRepository injectCardsRepository(){
  return CardsRepositoryImpl(remoteDataSource: injectFirebaseLockCardRemoteDataSource());
}

class CardsRepositoryImpl implements CardsRepository {

  FirebaseLockCardRemoteDataSource remoteDataSource;
  CardsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> addLock({required String uid, required LockCard lockCard}) async{
    await remoteDataSource.addLock(uid: uid, lockCard: lockCard.toDataSource());
  }

  @override
  Future<List<LockCard>> getCardsList({required String uid}) async{
    var response = await remoteDataSource.getCardsList(uid: uid);
    return response;
  }


}