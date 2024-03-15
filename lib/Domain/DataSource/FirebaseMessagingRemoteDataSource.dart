abstract class FirebaseMessagingRemoteDataSource {

  Future<void> subscribeToTopic({required String lockId}) ;
  Future<void> unsubscribeFromTopic({required String lockId});

}