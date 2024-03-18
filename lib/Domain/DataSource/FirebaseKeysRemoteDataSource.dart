import 'package:heimdall/Data/Models/Key/KeyDTO.dart';
import 'package:heimdall/Domain/Models/Key/Key.dart';

abstract class FirebaseKeysRemoteDataSource {

  Future<void> createKey({required KeyDTO key});
  Future<List<MyKey>> getKeys({required String uid});
}