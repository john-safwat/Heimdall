import 'package:heimdall/Data/DataSource/FirebaseKeysRemoteDataSourceImpl.dart';
import 'package:heimdall/Data/DataSource/FirebaseLockKeysRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseKeysRemoteDataSource.dart';
import 'package:heimdall/Domain/DataSource/FirebaseLockKeysRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';

KeysRepository injectKeysRepository() {
  return KeysRepositoryImpl(
      remoteDataSource: injectFirebaseKeysRemoteDataSource(),
      lockKeysRemoteDataSource: injectFirebaseLockKeysRemoteDataSource());
}

class KeysRepositoryImpl implements KeysRepository {
  FirebaseKeysRemoteDataSource remoteDataSource;
  FirebaseLockKeysRemoteDataSource lockKeysRemoteDataSource;

  KeysRepositoryImpl(
      {required this.remoteDataSource, required this.lockKeysRemoteDataSource});

  @override
  Future<void> createKey({required EKey key}) async {
    var response = await remoteDataSource.createKey(key: key.toDataSource());
    key.keyId = response;
    await lockKeysRemoteDataSource.createKey(key: key.toDataSource());
  }

  @override
  Future<List<EKey>> getUserKeys({required String uid}) async {
    var response = await remoteDataSource.getKeys(uid: uid);
    return response;
  }

  @override
  Future<List<EKey>> getLockKeys({required String lockId}) async{
    var response = await lockKeysRemoteDataSource.getKeys(lockId: lockId);
    return response;
  }
}
