import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Notification/NotificationDTO.dart';

FirebaseLockNotificationsDatabase injectFirebaseLockNotificationsDatabase() {
  return FirebaseLockNotificationsDatabase.getInstance();
}

class FirebaseLockNotificationsDatabase extends BaseDatabase {

  FirebaseLockNotificationsDatabase._();

  static FirebaseLockNotificationsDatabase? _instance;

  static getInstance() {
    return _instance ??= FirebaseLockNotificationsDatabase._();
  }

  CollectionReference<NotificationDTO> getCollectionReference() {
    return FirebaseFirestore.instance.collection(
        constants.notificationsCollection).withConverter(
      fromFirestore: (snapshot, options) =>
          NotificationDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),);
  }

  // function to get the notifications form Lock using the lock id
  Future<List<NotificationDTO>> getNotificationsList({required String lockId})async{
    var response = await getCollectionReference().where("id",isEqualTo: lockId).get();
    return response.docs.map((e) => e.data()).toList();
  }

  Future<void> addNotification({required NotificationDTO notification})async {
    var doc =  getCollectionReference().doc();
    notification.id = doc.id;
    await doc.set(notification);
  }
  
}