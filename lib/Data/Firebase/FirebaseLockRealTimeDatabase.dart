import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Core/Providers/LocksProvider.dart';

FirebaseLockRealTimeDatabase injectFirebaseLockRealTimeDatabase() {
  return FirebaseLockRealTimeDatabase.getInstance(
      provider: injectLocksProvider());
}

class FirebaseLockRealTimeDatabase extends BaseDatabase {
  LocksProvider provider;

  FirebaseLockRealTimeDatabase._(this.provider);

  static FirebaseLockRealTimeDatabase? _instance;

  static FirebaseLockRealTimeDatabase getInstance(
      {required LocksProvider provider}) {
    return _instance ??= FirebaseLockRealTimeDatabase._(provider);
  }

  DatabaseReference? starCountRef;
  StreamSubscription<DatabaseEvent>? listener;

  setDatabaseReference({required String lockId}) {
    starCountRef =
        FirebaseDatabase.instance.ref('${constants.locksCollection}/$lockId');
    listener = starCountRef!.onValue.listen((DatabaseEvent event) {
      DataSnapshot dataSnapshot = event.snapshot;
      Map<dynamic, dynamic> values =
          dataSnapshot.value as Map<dynamic, dynamic>;
      provider.updateValue(values, dataSnapshot.ref.key ?? "");
    });
  }

  Future<void> changeLockState({required bool lockState}) async {
    if (starCountRef == null) {
      return;
    }
    await starCountRef!.child("opened").set(lockState);
  }

  Future<String> getLockPassword({required String lockId}) async {
    var data = await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("password")
        .get();
    String password = data.value as String;
    return password;
  }

  Future<void> updatePassword(
      {required String lockId, required String password}) async {
    await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("password")
        .set(password);
  }

  Future<String> getLastImage({required String lockId}) async {
    var data = await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("lastImage")
        .get();
    String url = data.value as String;
    return url;
  }

  Future<bool> getUpdateState({required String lockId}) async {
    var data = await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("request_update")
        .get();
    bool state = data.value as bool;
    return state;
  }

  Future<(int, int, int, int)> getTripwirePoints(
      {required String lockId}) async {
    var data = await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("x1_value")
        .get();
    int x1 = data.value as int;
    data = await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("y1_value")
        .get();
    int y1 = data.value as int;
    data = await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("x2_value")
        .get();
    int x2 = data.value as int;
    data = await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("y2_value")
        .get();
    int y2 = data.value as int;

    return (x1, y1, x2, y2);
  }

  Future<void> updateImageState(
      {required String lockId, required bool state}) async {
    await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("request_update")
        .set(state);
  }

  Future<int> getTripwireTimer({required String lockId}) async {
    var data = await FirebaseDatabase.instance
        .ref('${constants.locksCollection}/$lockId')
        .child("alert_duration")
        .get();
    return data.value as int;
  }

  Future<void> updateTripwireParameters(
      {required String lockId,
      required int x1,
      required int x2,
      required int y1,
      required int y2,
      required int timer}) async {

    var ref  = FirebaseDatabase.instance.ref('${constants.locksCollection}/$lockId');
    await ref.child("alert_duration").set(timer);
    await ref.child("x1_value").set(x1);
    await ref.child("y1_value").set(y1);
    await ref.child("x2_value").set(x2);
    await ref.child("y2_value").set(y2);
  }
}
