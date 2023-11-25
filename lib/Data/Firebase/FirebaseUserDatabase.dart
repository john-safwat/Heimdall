
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Users/UserDTO.dart';


FirebaseUserDatabase injectFirebaseUserDatabase(){
  return FirebaseUserDatabase.getInstance();
}

class FirebaseUserDatabase {

  // singleton pattern
  FirebaseUserDatabase._();
  static FirebaseUserDatabase? _instance ;

  static FirebaseUserDatabase getInstance(){
    return _instance??=FirebaseUserDatabase._();
  }

  // function to get collection references of users collection in the app
  CollectionReference<UserDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection("Users").withConverter(
        fromFirestore: (snapshot, options) => UserDTO.fromFireStore(snapshot.data()!),
        toFirestore: (value, options) => value.toFireStore(),
    );
  }
  // function to upload user data to user data to database
  Future<void> createUser({required UserDTO user}) async {
    await getCollectionReference().doc(user.uid).set(user);
  }

  // function to update user data to user database in firebase fireStore
  Future<void> updateUserData({required UserDTO user}) async {
    await getCollectionReference().doc(user.uid).update(user.toFireStore());
  }

  // function to check if user Exist in database
  Future<bool> userExist({required String uid})async{
    var doc  = await getCollectionReference().doc(uid).get();
    return doc.exists;
  }

  Future<UserDTO?> getUserData({required String uid})async {
    var doc = await getCollectionReference().doc(uid).get();
    return doc.data();
  }

}