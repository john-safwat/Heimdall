import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Lock/LockDTO.dart';

FirebaseLockDatabase injectFirebaseLockDatabase(){
  return FirebaseLockDatabase.getInstance();
}

class FirebaseLockDatabase extends BaseDatabase {

  FirebaseLockDatabase._();

  static FirebaseLockDatabase? _instance;

  static FirebaseLockDatabase getInstance() {
    return _instance ??= FirebaseLockDatabase._();
  }

  CollectionReference<LockDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection(constants.locksCollection).withConverter(
        fromFirestore:(snapshot, options) => LockDTO.fromJson(snapshot.data()!),
        toFirestore: (value, options) => value.toJson(),
    );
  }

  Future<LockDTO> getLockData({required String lockId})async {
    var response = await getCollectionReference().doc(lockId).get();
    return response.data()!;
  }

  Future<void> updateLock({required LockDTO lock})async{
    await getCollectionReference().doc(lock.id).update(lock.toJson());
  }

}