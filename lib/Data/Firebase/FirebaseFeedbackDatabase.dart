
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
    return FirebaseFirestore.instance.collection("Feedback").withConverter(
      fromFirestore: (snapshot, options) => FeedbackDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // function to send feedback to database
  Future<String> addFeedback({required FeedbackDTO feedback})async{
    await getCollectionReference().doc().set(feedback);
    return "Feedback Sent";
  }

}