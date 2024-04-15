import 'package:heimdall/Domain/Models/Lock/Lock.dart';

abstract class LockRepository {

  Future<Lock> getLockData({required String lockId});
  Future<void> updateLock({required Lock lock});
  setDatabaseReference({required String lockId});
  Future<void> changeLockState({required bool lockState});
  Future<String> getLockPassword({required String lockId});
  Future<void> updatePassword({required String lockId , required String password});
}