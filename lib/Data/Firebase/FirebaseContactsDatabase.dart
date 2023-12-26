import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Contact/ContactDTO.dart';

FirebaseContactsDatabase injectFirebaseContactsDatabase() {
  return FirebaseContactsDatabase.getInstance();
}

class FirebaseContactsDatabase {
  // singleton pattern
  FirebaseContactsDatabase._();
  static FirebaseContactsDatabase? _instance;

  static FirebaseContactsDatabase getInstance() {
    return _instance ??= FirebaseContactsDatabase._();
  }

  // function to get Collection Reference
  CollectionReference<ContactDTO> getCollectionReference() {
    return FirebaseFirestore.instance.collection("Contacts").withConverter(
          fromFirestore: (snapshot, options) =>
              ContactDTO.fromFireStore(snapshot.data()!),
          toFirestore: (value, options) => value.toFireStore(),
        );
  }

  // validate if contact Exist
  Future<bool> contactExist(
      {required String firstUserUID, required String secondUserUID}) async {
    var firstCase = await getCollectionReference()
        .where("firstUserUID", isEqualTo: firstUserUID)
        .where("secondUserUID", isEqualTo: secondUserUID)
        .get();

    var firstUser = firstCase.docs.map((e) => e.data()).toList();

    if (firstUser.isNotEmpty){return true;}

    var secondCase = await getCollectionReference()
        .where("firstUserUID", isEqualTo: secondUserUID)
        .where("secondUserUID", isEqualTo: firstUserUID)
        .get();

    var secondUser = secondCase.docs.map((e) => e.data()).toList();

    return firstUser.isNotEmpty || secondUser.isNotEmpty ;
  }

  // function to create new Contact
  Future<ContactDTO> createContact({required ContactDTO contact})async{
    var doc = getCollectionReference().doc();
    contact.contactId = doc.id;
    await doc.set(contact);
    return contact;
  }

  // function to load rooms that user is the first user in
  Future<List<ContactDTO>> getFirstUserContact({required String uid})async{
    var response =await getCollectionReference().where("firstUserUID" , isEqualTo: uid).get();
    return response.docs.map((e) => e.data()).toList();
  }
  // function to load rooms that user is the second user in
  Future<List<ContactDTO>>  getSecondUserContact({required String uid})async{
    var response =await getCollectionReference().where("secondUserUID" , isEqualTo: uid).get();
    return response.docs.map((e) => e.data()).toList();
  }

  // function to delete user account contact
  Future<void> deleteUserContact({required String uid})async{
    var data = await getCollectionReference().where("firstUserUID" ,isEqualTo: uid).get();
    var list = data.docs.map((e) => e.data()).toList();
    for(int i = 0 ; i<list.length ; i++){
      await getCollectionReference().doc(list[i].contactId).delete();
    }
    data = await getCollectionReference().where("secondUserUID" ,isEqualTo: uid).get();
    list = data.docs.map((e) => e.data()).toList();
    for(int i = 0 ; i<list.length ; i++){
      await getCollectionReference().doc(list[i].contactId).delete();
    }
  }

}
