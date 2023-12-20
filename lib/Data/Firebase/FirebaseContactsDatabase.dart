
FirebaseContactsDatabase injectFirebaseContactsDatabase(){
  return FirebaseContactsDatabase.getInstance();
}

class FirebaseContactsDatabase {

  // singleton pattern
  FirebaseContactsDatabase._();
  static FirebaseContactsDatabase? _instance ;

  static FirebaseContactsDatabase getInstance(){
    return _instance??=FirebaseContactsDatabase._();
  }


}