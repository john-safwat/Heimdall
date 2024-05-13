import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Card/LockCardDTO.dart';

FirebaseCardsDatabase injectFirebaseCardsDatabase() {
  return FirebaseCardsDatabase.getInstance();
}

class FirebaseCardsDatabase extends BaseDatabase {
  // singleton pattern
  FirebaseCardsDatabase._();

  static FirebaseCardsDatabase? _instance;

  static FirebaseCardsDatabase getInstance() {
    return _instance ??= FirebaseCardsDatabase._();
  }

  CollectionReference<LockCardDTO> getCollectionReference(
      {required String uid}) {
    return FirebaseFirestore.instance
        .collection(constants.userCollection)
        .doc(uid)
        .collection(constants.locksCollection)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              LockCardDTO.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  Future<void> addLockCard(
      {required String uid, required LockCardDTO lockCard}) async {
    await getCollectionReference(uid: uid).doc(lockCard.lockId).set(lockCard);
  }

  Future<List<LockCardDTO>> getCardsList({required String uid}) async {
    var response = await getCollectionReference(uid: uid)
        .get()
        .then((value) => value.docs.map((e) => e.data()).toList());
    return response;
  }

  Future<LockCardDTO> getCard({required String uid , required String lockId})async{
    var response = await getCollectionReference(uid: uid).doc(lockId).get();
    return response.data()!;
  }

  Future<void> deleteLock({required String uid , required String lockId})async{

    await getCollectionReference(uid: uid).doc(lockId).delete();

  }
}
