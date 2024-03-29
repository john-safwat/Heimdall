import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Key/KeyDTO.dart';


FirebaseKeysDatabase injectFirebaseKeysDatabase(){
  return FirebaseKeysDatabase.getInstance();
}

class FirebaseKeysDatabase extends BaseDatabase {

  // singleton pattern
  FirebaseKeysDatabase._();

  static FirebaseKeysDatabase? _instance;

  static FirebaseKeysDatabase getInstance() {
    return _instance ??= FirebaseKeysDatabase._();
  }

  CollectionReference<KeyDTO> getCollectionReference(
      {required String uid}) {
    return FirebaseFirestore.instance
        .collection(constants.userCollection)
        .doc(uid)
        .collection(constants.keysCollection)
        .withConverter(
      fromFirestore: (snapshot, options) =>
          KeyDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }

  Future<String> createKey({required KeyDTO key}) async {
    var doc = getCollectionReference(uid: key.userId!).doc();
    key.keyId = doc.id;
    await doc.set(key);
    return doc.id;
  }

  Future<void> updateKey({required KeyDTO key}) async {
    await getCollectionReference(uid: key.userId!).doc(key.keyId).update(key.toFireStore());
  }

  Future<void> deleteKey({required KeyDTO key}) async {
    await getCollectionReference(uid: key.userId!).doc(key.keyId).delete();
  }

  Future<List<KeyDTO>> getKeys({required String uid})async {
    var response = await getCollectionReference(uid: uid).get();
    return response.docs.map((e) => e.data()).toList();
  }

}