abstract class FirebaseLockRealtimeDatabaseRemoteDataSource {

  setDatabaseReference({required String lockId});
  Future<void> changeLockState({required bool lockState});
}