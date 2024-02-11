import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heimdall/Core/Base/BaseDatabase.dart';
import 'package:heimdall/Data/Models/Chat/ChatDTO.dart';

FirebaseChatDatabase injectFirebaseChatDatabase(){
  return FirebaseChatDatabase.getInstance();
}

class FirebaseChatDatabase extends BaseDatabase{

  // singleton pattern
  FirebaseChatDatabase._();
  static FirebaseChatDatabase? _instance;

  static FirebaseChatDatabase getInstance() {
    return _instance ??= FirebaseChatDatabase._();
  }

  // get collection Messages collection references
   CollectionReference<ChatDTO> getCollectionReference(String contactId){
    return FirebaseFirestore.instance.collection(constants.contactsCollection).doc(contactId).collection(ChatDTO.collectionName).withConverter(
      fromFirestore: (snapshot, options) => ChatDTO.fromFireStore(snapshot.data()!),
      toFirestore: (value, options) => value.toFireStore(),
    );
  }

  // function to send message to database
  Future<void> sendMessage({required String contactId ,required ChatDTO chat})async{
    var ref = getCollectionReference(contactId).doc();
    chat.messageID = ref.id;
    await ref.set(chat);
  }
  Stream<QuerySnapshot<ChatDTO>> getMessagesStream({required String contactId}){
    return getCollectionReference(contactId).snapshots();
  }
}