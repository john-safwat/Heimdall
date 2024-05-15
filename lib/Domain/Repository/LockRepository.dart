import 'package:heimdall/Domain/Models/Lock/Lock.dart';

abstract class LockRepository {

  Future<Lock> getLockData({required String lockId});
  Future<void> updateLock({required Lock lock});
  setDatabaseReference({required String lockId});
  Future<void> changeLockState({required bool lockState});
  Future<String> getLockPassword({required String lockId});
  Future<void> updatePassword({required String lockId , required String password});
  Future<String> getLastImage({required String lockId});
  Future<bool> getUpdateState({required String lockId});
  Future<(int , int , int , int)> getTripwirePoints({required String lockId}) ;
  Future<void> updateImageState({required String lockId , required bool state});
  Future<int> getTripwireTimer({required String lockId });
  Future<void> updateTripwireParameters(
      {required String lockId,
        required int x1,
        required int x2,
        required int y1,
        required int y2,
        required int timer});
}