
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Data/Models/Feedback/FeedbackDTO.dart';

FirebaseFeedbackDatabase injectFirebaseFeedbackDatabase(){
  return FirebaseFeedbackDatabase.getInstance();
}

class FirebaseFeedbackDatabase {

  // singleton pattern
  FirebaseFeedbackDatabase._();
  static FirebaseFeedbackDatabase? _instance;

  static FirebaseFeedbackDatabase getInstance() {
    return _instance ??= FirebaseFeedbackDatabase._();
  }

  // get collection Feedback collection references
  CollectionReference<FeedbackDTO> getCollectionReference(){
    return FirebaseFirestore.instance.collection("Feedbacks").withConverter(
      fromFirestore: (snapshot, options) => FeedbackDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // function to send feedback to database
  Future<String> addFeedback({required FeedbackDTO feedback})async{
    var ref = getCollectionReference().doc();
    feedback.id = ref.id;
    await ref.set(feedback);
    return "Feedback Sent";
  }

  // function to delete user account feedback
  Future<void> deleteUserFeedbacks({required String uid})async{
    var data = await getCollectionReference().where("uid" ,isEqualTo: uid).get();
    var list = data.docs.map((e) => e.data()).toList();
    for(int i = 0 ; i<list.length ; i++){
      await getCollectionReference().doc(list[i].id).delete();
    }
  }

}