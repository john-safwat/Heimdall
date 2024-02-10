import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Card/LockCardDTO.dart';

FirebaseCardsDatabase injectFirebaseCardsDatabase(){
  return FirebaseCardsDatabase.getInstance();
}

class FirebaseCardsDatabase {

  // singleton pattern
  FirebaseCardsDatabase._();
  static FirebaseCardsDatabase? _instance;

  static FirebaseCardsDatabase getInstance() {
    return _instance ??= FirebaseCardsDatabase._();
  }

  CollectionReference<LockCardDTO> getCollectionReference({required String uid}){
    return FirebaseFirestore.instance.collection("Users").doc(uid).collection("Locks").withConverter(
        fromFirestore: (snapshot, options) => LockCardDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }

  Future<void> addLockCard({required String uid , required LockCardDTO lockCard})async{
    var doc =  getCollectionReference(uid: uid).doc();
    lockCard.cardId =doc.id;
    await doc.set(lockCard);
  }
    
}