import 'package:heimdall/Domain/Models/Key/Key.dart';

abstract class KeysRepository {

  Future<void> createKey({required MyKey key});
  Future<List<MyKey>> getKeys({required String uid});
}