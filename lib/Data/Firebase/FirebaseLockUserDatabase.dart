import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Users/UserDTO.dart';

FirebaseLockUsersDatabase injectFirebaseLockUsersDatabase(){
  return FirebaseLockUsersDatabase.getInstance();
}

class FirebaseLockUsersDatabase extends BaseDatabase {

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  FirebaseLockUsersDatabase._();

  static FirebaseLockUsersDatabase? _instance;

  static FirebaseLockUsersDatabase getInstance() {
    return _instance ??= FirebaseLockUsersDatabase._();
  }

  CollectionReference<UserDTO> getCollectionReference(
      {required String lockId}) {
    return _firebaseFireStore.collection(constants.locksCardCollection).doc(
        lockId).collection(constants.userCollection).withConverter(
        fromFirestore: (snapshot, options) => UserDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }

  Future<void> addLockUser({required String lockId , required UserDTO userDTO})async{
    await getCollectionReference(lockId: lockId).doc(userDTO.uid).set(userDTO);
  }

}