import 'package:heimdall/Domain/Models/Key/Key.dart';

abstract class KeysRepository {

  Future<void> createKey({required EKey key});
  Future<List<EKey>> getUserKeys({required String uid});
  Future<List<EKey>> getLockKeys({required String lockId});
}