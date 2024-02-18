import 'package:heimdall/Domain/Models/Lock/Lock.dart';

abstract class LockRepository {

  Future<Lock> getLockData({required String lockId});
  Future<void> updateLock({required Lock lock});
}