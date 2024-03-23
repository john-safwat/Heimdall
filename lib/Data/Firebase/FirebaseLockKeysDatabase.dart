import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Key/KeyDTO.dart';


FirebaseLockKeysDatabase injectFirebaseLockKeysDatabase(){
  return FirebaseLockKeysDatabase.getInstance();
}

class FirebaseLockKeysDatabase extends BaseDatabase {

  // singleton pattern
  FirebaseLockKeysDatabase._();

  static FirebaseLockKeysDatabase? _instance;

  static FirebaseLockKeysDatabase getInstance() {
    return _instance ??= FirebaseLockKeysDatabase._();
  }

  CollectionReference<KeyDTO> getCollectionReference(
      {required String lockId}) {
    return FirebaseFirestore.instance
        .collection(constants.locksCollection)
        .doc(lockId)
        .collection(constants.keysCollection)
        .withConverter(
      fromFirestore: (snapshot, options) =>
          KeyDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }

  Future<void> createKey({required KeyDTO key}) async {
    await getCollectionReference(lockId: key.lockId!).doc(key.keyId).set(key);
  }

  Future<void> updateKey({required KeyDTO key}) async {
    await getCollectionReference(lockId: key.lockId!).doc(key.keyId).update(key.toFireStore());
  }

  Future<void> deleteKey({required KeyDTO key}) async {
    await getCollectionReference(lockId: key.lockId!).doc(key.keyId).delete();
  }

  Future<List<KeyDTO>> getKeys({required String lockId})async {
    var response = await getCollectionReference(lockId: lockId).get();
    return response.docs.map((e) => e.data()).toList();
  }

}