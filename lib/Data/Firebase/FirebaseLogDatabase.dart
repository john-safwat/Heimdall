import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Log/LogDTO.dart';

FirebaseLogDatabase injectFirebaseLogDatabase(){
  return FirebaseLogDatabase.getInstance();
}

class FirebaseLogDatabase extends BaseDatabase{

  FirebaseLogDatabase._();

  static FirebaseLogDatabase? _instance;

  static getInstance() {
    return _instance ??= FirebaseLogDatabase._();
  }

  CollectionReference<LogDTO> getCollectionReference() {
    return FirebaseFirestore.instance.collection(
        constants.logCollection).withConverter(
      fromFirestore: (snapshot, options) =>
          LogDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),);
  }


  Future<void> addLog({required LogDTO log})async {
    await getCollectionReference().doc().set(log);
  }

}