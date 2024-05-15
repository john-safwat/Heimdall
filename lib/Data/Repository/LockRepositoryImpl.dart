import 'package:heimdall/Data/DataSource/FirebaseLockRealtimeDatabaseRemoteDataSourceImpl.dart';
import 'package:heimdall/Data/DataSource/FirebaseLockRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockRealtimeDatabaseRemoteDataSource.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Lock/Lock.dart';
import 'package:heimdall/Domain/Repository/LockRepository.dart';

LockRepository injectLockRepository() {
  return LockRepositoryImpl(
      lockRemoteDataSource: injectFirebaseLockRemoteDataSource(),
      lockRealtimeDatabaseRemoteDataSource:
      injectFirebaseLockRealtimeDatabaseRemoteDataSource());
}

class LockRepositoryImpl implements LockRepository {
  FirebaseLockRemoteDataSource lockRemoteDataSource;
  FirebaseLockRealtimeDatabaseRemoteDataSource
  lockRealtimeDatabaseRemoteDataSource;

  LockRepositoryImpl({required this.lockRemoteDataSource,
    required this.lockRealtimeDatabaseRemoteDataSource});

  @override
  Future<Lock> getLockData({required String lockId}) async {
    var response = await lockRemoteDataSource.getLockData(lockId: lockId);
    return response;
  }

  @override
  Future<void> updateLock({required Lock lock}) async {
    await lockRemoteDataSource.updateLock(lock: lock.toDataSource());
  }

  @override
  setDatabaseReference({required String lockId}) {
    lockRealtimeDatabaseRemoteDataSource.setDatabaseReference(lockId: lockId);
  }

  @override
  Future<void> changeLockState({required bool lockState}) async {
    await lockRealtimeDatabaseRemoteDataSource.changeLockState(
        lockState: lockState);
  }

  @override
  Future<String> getLockPassword({required String lockId}) async {
    var response = await lockRealtimeDatabaseRemoteDataSource.getLockPassword(
        lockId: lockId);
    return response;
  }

  @override
  Future<void> updatePassword(
      {required String lockId, required String password}) async {
    await lockRealtimeDatabaseRemoteDataSource.updatePassword(
        lockId: lockId, password: password);
  }

  @override
  Future<String> getLastImage({required String lockId}) async {
    var response =
    await lockRealtimeDatabaseRemoteDataSource.getLastImage(lockId: lockId);
    return response;
  }

  @override
  Future<bool> getUpdateState({required String lockId}) async {
    var response = await lockRealtimeDatabaseRemoteDataSource.getUpdateState(
        lockId: lockId);
    return response;
  }

  @override
  Future<(int, int, int, int)> getTripwirePoints(
      {required String lockId}) async {
    var response = await lockRealtimeDatabaseRemoteDataSource.getTripwirePoints(
        lockId: lockId);
    return response;
  }

  @override
  Future<void> updateImageState(
      {required String lockId, required bool state}) async {
    await lockRealtimeDatabaseRemoteDataSource.updateImageState(
        lockId: lockId, state: state);
  }

  @override
  Future<int> getTripwireTimer({required String lockId}) async {
    var response = await lockRealtimeDatabaseRemoteDataSource.getTripwireTimer(
        lockId: lockId);
    return response;
  }

  @override
  Future<void> updateTripwireParameters({required String lockId,
    required int x1,
    required int x2,
    required int y1,
    required int y2,
    required int timer}) async {
    await lockRealtimeDatabaseRemoteDataSource.updateTripwireParameters(
        lockId: lockId,
        x1: x1,
        x2: x2,
        y1: y1,
        y2: y2,
        timer: timer);
  }
}
