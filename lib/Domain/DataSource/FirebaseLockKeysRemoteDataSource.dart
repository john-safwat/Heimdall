import 'package:heimdall/Data/Models/Key/KeyDTO.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';

abstract class FirebaseLockKeysRemoteDataSource {

  Future<void> createKey({required KeyDTO key});
  Future<List<EKey>> getKeys({required String lockId});
  Future<void> updateKey({required KeyDTO key});
  Future<void> deleteKey({required KeyDTO key});
}