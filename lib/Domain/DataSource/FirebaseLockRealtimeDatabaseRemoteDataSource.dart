abstract class FirebaseLockRealtimeDatabaseRemoteDataSource {

  setDatabaseReference({required String lockId});
  Future<void> changeLockState({required bool lockState});
  Future<String> getLockPassword({required String lockId});
  Future<void> updatePassword({required String lockId , required String password});
}