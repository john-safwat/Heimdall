import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';

FirebaseLockRealTimeDatabase injectFirebaseLockRealTimeDatabase(){
  return FirebaseLockRealTimeDatabase.getInstance(provider: injectLocksProvider());
}

class FirebaseLockRealTimeDatabase extends BaseDatabase {

  LocksProvider provider;
  FirebaseLockRealTimeDatabase._(this.provider);

  static FirebaseLockRealTimeDatabase? _instance;

  static FirebaseLockRealTimeDatabase getInstance({required LocksProvider provider}) {
    return _instance ??= FirebaseLockRealTimeDatabase._(provider);
  }

  DatabaseReference? starCountRef;
  StreamSubscription<DatabaseEvent>? listener ;

  setDatabaseReference({required String lockId}){
    starCountRef = FirebaseDatabase.instance.ref('${constants.locksCollection}/$lockId');
    listener = starCountRef!.onValue.listen((DatabaseEvent event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic> values = dataSnapshot.value as Map<dynamic, dynamic>;
      provider.updateValue(values , dataSnapshot.ref.key??"");
    });
  }


  Future<void> changeLockState({required bool lockState})async{
    if(starCountRef == null){return;}
    await starCountRef!.child("opened").set(lockState);
  }

}