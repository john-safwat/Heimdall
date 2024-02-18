
import 'package:heimdall/Data/Models/Lock/LockDTO.dart';
import 'package:heimdall/Domain/Models/Lock/Lock.dart';

abstract class FirebaseLockRemoteDataSource {

  Future<Lock> getLockData({required String lockId});
  Future<void> updateLock({required LockDTO lock});
}