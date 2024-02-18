import 'package:heimdall/Data/DataSource/FirebaseLockRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Lock/Lock.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

LockRepository injectLockRepository(){
  return LockRepositoryImpl(lockRemoteDataSource: injectFirebaseLockRemoteDataSource());
}

class LockRepositoryImpl implements LockRepository {

  FirebaseLockRemoteDataSource lockRemoteDataSource;
  LockRepositoryImpl({required this.lockRemoteDataSource});

  @override
  Future<Lock> getLockData({required String lockId}) async {
    var response = await lockRemoteDataSource.getLockData(lockId: lockId);
    return response;
  }

  @override
  Future<void> updateLock({required Lock lock}) async{
    await lockRemoteDataSource.updateLock(lock: lock.toDataSource());
  }

}