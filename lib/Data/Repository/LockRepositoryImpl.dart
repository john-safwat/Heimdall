import 'package:heimdall/Data/DataSource/FirebaseLockRealtimeDatabaseRemoteDataSourceImpl.dart';
import 'package:heimdall/Data/DataSource/FirebaseLockRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockRealtimeDatabaseRemoteDataSource.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Lock/Lock.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

LockRepository injectLockRepository(){
  return LockRepositoryImpl(
    lockRemoteDataSource: injectFirebaseLockRemoteDataSource(),
    lockRealtimeDatabaseRemoteDataSource: injectFirebaseLockRealtimeDatabaseRemoteDataSource()
  );
}

class LockRepositoryImpl implements LockRepository {

  FirebaseLockRemoteDataSource lockRemoteDataSource;
  FirebaseLockRealtimeDatabaseRemoteDataSource lockRealtimeDatabaseRemoteDataSource;
  LockRepositoryImpl({required this.lockRemoteDataSource , required this.lockRealtimeDatabaseRemoteDataSource});

  @override
  Future<Lock> getLockData({required String lockId}) async {
    var response = await lockRemoteDataSource.getLockData(lockId: lockId);
    return response;
  }

  @override
  Future<void> updateLock({required Lock lock}) async{
    await lockRemoteDataSource.updateLock(lock: lock.toDataSource());
  }

  @override
  setDatabaseReference({required String lockId}) {
    lockRealtimeDatabaseRemoteDataSource.setDatabaseReference(lockId: lockId);
  }

  @override
  Future<void> changeLockState({required bool lockState}) async{
    await lockRealtimeDatabaseRemoteDataSource.changeLockState(lockState: lockState);
  }

}