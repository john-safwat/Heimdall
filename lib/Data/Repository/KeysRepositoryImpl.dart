import 'package:heimdall/Data/DataSource/FirebaseKeysRemoteDataSourceImpl.dart';
import 'package:heimdall/Domain/DataSource/FirebaseKeysRemoteDataSource.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';
import 'package:heimdall/Domain/Repository/KeysRepository.dart';

KeysRepository injectKeysRepository() {
  return KeysRepositoryImpl(
      remoteDataSource: injectFirebaseKeysRemoteDataSource());
}

class KeysRepositoryImpl implements KeysRepository {
  FirebaseKeysRemoteDataSource remoteDataSource;

  KeysRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createKey({required MyKey key}) async {
    await remoteDataSource.createKey(key: key.toDataSource());
  }

  @override
  Future<List<MyKey>> getKeys({required String uid}) async{
    var response = await remoteDataSource.getKeys(uid: uid);
    return response;
  }
}
