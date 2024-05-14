abstract class FirebaseLockRealtimeDatabaseRemoteDataSource {

  setDatabaseReference({required String lockId});
  Future<void> changeLockState({required bool lockState});
  Future<String> getLockPassword({required String lockId});
  Future<void> updatePassword({required String lockId , required String password});
  Future<String> getLastImage({required String lockId});
  Future<bool> getUpdateState({required String lockId});
  Future<(int , int , int , int)> getTripwirePoints({required String lockId}) ;
  Future<void> updateImageState({required String lockId , required bool state});
}